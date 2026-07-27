# Phase 1: Moodle Foundation — Auth + Course List

**Date:** 2026-07-16
**Status:** Approved

## Purpose

Stand up the plumbing every other Moodle Student feature depends on: a client capable of
talking to Moodle's Web Service (WS) protocol, and one real end-to-end vertical slice
(login → course list) that proves the pattern against a live site before any other
feature is built on top of it.

Full target scope (all tiers, all activity modules) is documented in
[`docs/moodle-student-app-scope.md`](../../moodle-student-app-scope.md). This spec covers
**only** the foundation slice — Tier 0's auth/session piece plus the first Tier 1 feature
(My Courses) — deliberately deferring SSO, offline sync, and every other Tier 1/2/3
feature to later phases.

## Why a Custom Client, Not Retrofit

Moodle's WS protocol is not resource-based REST: every call is a `POST` to the single
route `/webservice/rest/server.php` with a `wsfunction` name and flattened params, and
errors come back as **HTTP 200** with an `exception`/`errorcode` field in the JSON body
rather than a non-2xx status. Retrofit's per-endpoint, per-verb model doesn't fit — a
generic `@POST` catch-all would give none of Retrofit's type safety while still needing
custom body-shape error detection. A small hand-rolled client (matching how the official
Moodle app's own `ws.ts` is built — also hand-rolled, not REST-codegen) is simpler and
more honest about what the protocol actually is.

## Verified Existing Conventions This Design Builds On

(Confirmed by reading the actual code, not just `CLAUDE.md`, since the two had drifted apart.)

- **`Result<T> = (T?, AppFailure?)`** (`core/lib/utils/network/result.dart`) — a positional
  record, not `Either`. All new repository/use-case methods return this.
- **`AppFailure`** sealed-ish hierarchy (`core/lib/utils/failure/app_failure.dart`) already
  has `NetworkFailure`, `CacheFailure`, `ValidationFailure`, `AuthFailure` (with a
  `canRefresh` flag), `UnknownFailure`. This phase adds one sibling: `MoodleWsFailure`.
- **`ApiClient`** (`core/lib/utils/network/api_client.dart`) is an existing `@LazySingleton`
  Dio wrapper with `get/post/put/patch/delete`, timeout + logging interceptors, and
  HTTP-status-code error mapping. It's reused as the transport for Moodle calls (see
  below) rather than duplicated.
- **Entities are plain immutable classes** (manual `copyWith`/`==`/`hashCode`, no
  `Equatable`, no `freezed`) — see `domain/lib/feature_post/entities/post_entity.dart`.
- **Models are `@freezed` + `json_serializable`**, converted to/from entities via
  `toEntity()`/`toModel()` extensions, not inheritance — see
  `data/lib/feature_post/models/post_model.dart`.
- **`lib/routes/app_router.dart`** already has an `isLoggedIn` callback and
  `redirectLocation` parameter on `AppRouter.getRouter(...)`, and `AppRoutes.login` /
  `AppRoutes.splash` constants already exist — but neither is actually wired to a
  `redirect:` callback yet, and `initialLocation` is hardcoded to `AppRoutes.posts`. This
  phase is what finally wires them up.
- **No existing pattern fits a runtime-supplied base URL.** `ApiClient` bakes a fixed
  `baseUrl` into `Dio.options` once, from `FlavorConfig`/`AppConstants.baseUrl`, at DI
  construction. A Moodle site URL is self-hosted and user-supplied at login time, so
  nothing here can rely on that fixed base URL — see the client design below.

## Architecture

### `core/lib/utils/moodle/` (new — cross-cutting infra, not feature-specific)

**`moodle_ws_client.dart` — `MoodleWsClient`**
```dart
Future<Result<Map<String, dynamic>>> call(
  String wsFunction, {
  required String siteUrl,
  required String wsToken,
  Map<String, dynamic> params = const {},
});
```
- Builds the **absolute** URL `$siteUrl/webservice/rest/server.php` and passes it as the
  `path` argument to `apiClient.post()`. Dio treats an absolute path as overriding
  `baseUrl` entirely, so this needs **zero changes** to `ApiClient`'s constructor, its
  `@LazySingleton` registration, or `FlavorConfig` — the existing fixed-baseUrl `ApiClient`
  keeps working unmodified for any future non-Moodle calls.
- Sends `wstoken`, `wsfunction`, `moodlewsrestformat: 'json'` plus `params` flattened into
  Moodle's bracketed form-field convention (`courseids[0]=5`, `options[0][name]=x`) as a
  `FormData` body (Moodle's REST server expects form-encoded POST params, not a JSON body).
- `apiClient.post()` already returns `Result<T>`, handling transport/HTTP failures via the
  existing `NetworkFailure` mapping. `MoodleWsClient` then inspects the **body** of a
  successful `Result`: if it decodes to a `Map` containing `exception`/`errorcode`, it
  converts the result to a failure —
  - `errorcode` is `invalidtoken` / `accessexception` / `invalidlogin` → `AuthFailure`
    (reuses the existing type; `canRefresh: false`, since Moodle mobile tokens aren't
    refreshable — the user re-authenticates)
  - anything else → the new `MoodleWsFailure(errorcode, message)`
  - otherwise → `Result.success(body)`

**`moodle_params.dart`** — pure function flattening nested `Map`/`List` params into
Moodle's indexed bracket keys. Unit-testable in isolation with no Dio/network dependency.

**`current_site_store.dart` — `CurrentSiteStore`** (`@lazySingleton`)
In-memory holder for the active `siteUrl` / `wsToken` / decoded `siteinfo` map once
logged in, so any feature can synchronously ask "am I logged in, and to what site"
without an async storage read on every use. Populated by `RestoreSessionUseCase` on app
start and by `LoginUseCase` on success; cleared by `LogoutUseCase`.

### `core/lib/utils/failure/app_failure.dart` (extend, don't replace)

```dart
class MoodleWsFailure extends AppFailure {
  const MoodleWsFailure({
    required super.message,
    required this.errorcode,
    this.exception,
    super.stackTrace,
  }) : super(code: 'MOODLE_WS_FAILURE');

  final String errorcode;   // Moodle's own machine code, e.g. "invalidparameter"
  final String? exception;  // Moodle's PHP exception class name, for debugging

  @override
  Map<String, dynamic> toJson() =>
      {'code': code, 'message': message, 'errorcode': errorcode, 'exception': exception};
}
```

### `core/lib/utils/storage/secure_storage.dart` (new)

`LocalStorage` (Hive/SharedPreferences) isn't encrypted at rest — fine for cached
`siteinfo`, wrong for a long-lived credential-equivalent token. New minimal interface,
same `Result`-returning shape as `LocalStorage` for consistency:

```dart
abstract class SecureStorage {
  Future<Result<String?>> read(String key);
  Future<Result<bool>> write(String key, String value);
  Future<Result<bool>> delete(String key);
}
```
Implemented with the `flutter_secure_storage` package (new dependency, added to
`core/pubspec.yaml`) using Keychain (iOS) / Keystore (Android). Registered
`@LazySingleton(as: SecureStorage)`.

### `domain/lib/feature_auth/` + `data/lib/feature_auth/` + `lib/feature_auth/`

**Domain entities** (plain classes, matching `PostEntity`):
- `SiteEntity { siteUrl, siteName, logoUrl }`
- `SessionEntity { userId, fullName, token, siteUrl }`

**Domain repository:**
```dart
abstract class AuthRepository {
  Future<Result<SessionEntity>> login({
    required String siteUrl,
    required String username,
    required String password,
  });
  Future<Result<SessionEntity?>> restoreSession();
  Future<Result<bool>> logout();
}
```

**Use cases** (thin wrappers, matching the `feature_post` use-case style — no shared
`UseCase<T,P>` base class exists in this codebase, and this phase doesn't introduce one):
`LoginUseCase`, `RestoreSessionUseCase`, `LogoutUseCase`.

**Data layer:**
- `models/session_model.dart` — `@freezed SessionModel`, `fromJson`/`toJson`,
  `toEntity()`/`toModel()` extensions, matching `PostModel`.
- `datasources/auth_remote_datasource.dart` — two calls via `ApiClient`/`MoodleWsClient`:
  1. `POST {siteUrl}/login/token.php` (`username`, `password`, `service: 'moodle_mobile_app'`)
     — this is a **separate, non-WS endpoint** (no `wsfunction`), called directly through
     `apiClient.post()` rather than through `MoodleWsClient` (which only targets
     `webservice/rest/server.php`). It uses the same absolute-URL-overrides-baseUrl
     mechanism described above — `apiClient.post('$siteUrl/login/token.php', data: ...)`.
  2. `MoodleWsClient.call('core_webservice_get_site_info', siteUrl: ..., wsToken: <from step 1>)`
     to fetch `userid`, `fullname`, and site capabilities.
- `datasources/auth_local_datasource.dart` — wraps `SecureStorage` (token, siteUrl) +
  `LocalStorage` (cached `siteinfo` JSON).
- `repositories/auth_repository_impl.dart` — orchestrates the two remote calls, persists
  on success, populates `CurrentSiteStore`, maps `DioException`/`MoodleWsFailure` per the
  existing `_mapDioError`/`_mapUnknownError` pattern from `PostRepositoryImpl`.

**Presentation:**
- `cubit/login_cubit.dart` — `@freezed LoginState` (`initial`, `loading`, `success`,
  `error(AppFailure)`), matching `PostState`'s shape.
- `pages/login_page.dart` — two-step form: site URL field first (no validation call in
  this phase — just normalize `https://` prefix and strip trailing slash), then
  username/password once a site URL is entered.
- `AppRoutes.login` (already exists as a constant, currently unused) becomes the actual
  login route.

### `domain/lib/feature_courses/` + `data/lib/feature_courses/` + `lib/feature_courses/`

Same three-layer shape:
- Entity: `CourseEntity { id, fullName, shortName, summary, courseImageUrl }`
- Repository: `CourseRepository.getUserCourses()` → `Result<List<CourseEntity>>`
- Use case: `GetUserCoursesUseCase`
- Data source: `MoodleWsClient.call('core_enrol_get_users_courses', params: {'userid': userId})`,
  reading `userId`/`siteUrl`/`wsToken` from `CurrentSiteStore`
- `cubit/courses_cubit.dart` + `pages/courses_page.dart` — list with `shimmer` loading
  placeholders and `pull_to_refresh` (both already dependencies, currently unused
  anywhere in the app)
- New route `AppRoutes.courses = '/courses'`

### Routing (`lib/routes/app_router.dart`, `app_routes.dart`)

This phase is what actually wires the `isLoggedIn`/`redirectLocation` params that already
exist on `AppRouter.getRouter()` but currently do nothing:
- Add a `redirect:` callback: unauthenticated + not already on `/login` → redirect to
  `AppRoutes.login`; authenticated + on `/login` → redirect to `AppRoutes.courses`.
- `main.dart` calls `RestoreSessionUseCase` before building the router, passes the result
  as the `isLoggedIn` closure.
- `initialLocation` changes from the hardcoded `AppRoutes.posts` to `AppRoutes.splash`
  (a minimal loading screen shown while `RestoreSessionUseCase` runs), which then
  redirects to `login` or `courses`.
- `AppRoutes.posts` (the JSONPlaceholder demo) stays registered and reachable by direct
  navigation — not touched, not removed.

### DI (`core/lib/utils/injection/di_module.dart`, `lib/src/injection/di.dart`)

Register, mirroring the existing `di_module.dart`/`di.dart` registration style:
- `SecureStorage` implementation (`@LazySingleton(as: SecureStorage)`)
- `MoodleWsClient` (`@lazySingleton`, depends on `ApiClient`)
- `CurrentSiteStore` (`@lazySingleton`)
- `AuthRemoteDatasource`, `AuthLocalDatasource`, `AuthRepository` → `AuthRepositoryImpl`,
  the three auth use cases, `LoginCubit`
- `CourseRemoteDatasource`, `CourseRepository` → `CourseRepositoryImpl`,
  `GetUserCoursesUseCase`, `CoursesCubit`

Run `fvm flutter pub run build_runner build --delete-conflicting-outputs` after annotations
land.

## Data Flow

1. **App start:** `main.dart` calls `RestoreSessionUseCase` → reads `SecureStorage` for a
   saved token; if present, calls `core_webservice_get_site_info` to confirm it's still
   valid, populates `CurrentSiteStore`. Result feeds the router's `isLoggedIn`.
2. **No session:** router redirects to `/login`. User enters site URL, then
   username/password. `LoginUseCase` → `POST /login/token.php` → `wstoken` →
   `core_webservice_get_site_info` (userid, fullname, capabilities) → persist token
   (`SecureStorage`) + siteinfo (`LocalStorage`) → populate `CurrentSiteStore` → emit
   `LoginState.success` → router redirects to `/courses`.
3. **Courses page:** `GetUserCoursesUseCase` → `MoodleWsClient.call('core_enrol_get_users_courses', ...)`
   → maps the JSON array to `List<CourseEntity>` → `CoursesCubit` emits
   loading/success/error → UI renders the list (shimmer while loading, pull-to-refresh to
   reload).
4. **Logout:** `LogoutUseCase` clears `SecureStorage` + cached siteinfo + `CurrentSiteStore`,
   router redirects to `/login`.

## Error Handling

Follows the existing rule (`PostRepositoryImpl`'s pattern): no `try/catch` in
domain/presentation, only the data-layer repository implementation catches
`DioException`/unexpected exceptions and maps to `AppFailure` subclasses.

- Transport-level failures (timeout, DNS failure on a bad site URL, no connection) →
  `NetworkFailure`, already handled by `ApiClient`'s existing status-code/timeout mapping.
- Moodle body-level errors (`errorcode` present in an HTTP-200 body) → `AuthFailure` for
  `invalidtoken`/`accessexception`/`invalidlogin`, `MoodleWsFailure` for everything else —
  both produced inside `MoodleWsClient`, so no feature-level code needs to know about the
  Moodle error-shape quirk.
- `AuthFailure` anywhere in the app (not just from login) is treated by the relevant
  Cubit as "force logout" — clears the session and lets the router's `redirect:` bounce
  to `/login`. This makes an expired/revoked token self-healing everywhere, not just on
  the login screen.

## Testing

- `MoodleWsClient` unit tests (highest value — everything else depends on this being
  correct): param flattening shape, success-body passthrough, `errorcode`→failure mapping
  for both the `AuthFailure` and `MoodleWsFailure` branches, using a mocked `ApiClient`.
- `moodle_params.dart` flattening function: pure-function tests, no mocking needed.
- Use case tests (`LoginUseCase`, `RestoreSessionUseCase`, `LogoutUseCase`,
  `GetUserCoursesUseCase`): mockito mocks of the repository, mirroring
  `get_post_usecase_test.dart`.
- Repository impl tests: mocked data sources, verifying success mapping and
  `DioException`/`MoodleWsFailure` → `AppFailure` mapping, mirroring
  `post_repository_impl_test.dart`.
- Cubit tests: `blocTest` covering initial/loading/success/error, mirroring
  `post_cubit_test.dart`.
- Router redirect logic: widget/unit test asserting unauthenticated → `/login` and
  authenticated-on-`/login` → `/courses`.
- **Manual smoke test** (not automated — needs live credentials): login and course list
  against the real test Moodle site. Phase 1 isn't done until this passes, since it's the
  only thing that actually validates the protocol assumptions above against a live server.
- Verification gate: `fvm flutter analyze` and `fvm flutter test` must pass.

## Out of Scope (deferred to later phases)

- SSO / browser-based `launch.php` login, site search, QR-code login, guest login.
- Offline sync / write queue for any module (flagged in the scope doc as a first-class
  cost driver, but genuinely orthogonal to proving the foundation works).
- Token refresh (Moodle mobile tokens aren't refreshable server-side in the same way as
  OAuth; `AuthFailure.canRefresh` stays `false` for now — re-auth is the only path).
- Dashboard blocks, calendar, grades, messaging, and all Tier 2 activity modules — each
  gets its own phase once this foundation is validated.
- `tool_mobile_call_external_functions` batching — worth adopting once more than one
  `MoodleWsClient.call()` fires on the same screen (e.g. a real dashboard), not needed for
  a single-call course list.
- Any change to `feature_post` (JSONPlaceholder demo) — left as-is, it's an unrelated
  example feature.
