# Feature: JSONPlaceholder Post CRUD

**Date:** 2026-07-15
**Status:** Approved

## Purpose

Add a complete, working example of all five HTTP verbs (GET, POST, PUT, PATCH, DELETE)
against the public [JSONPlaceholder](https://jsonplaceholder.typicode.com/) `/posts`
resource, built as a new Clean Architecture feature module (`feature_post`) that mirrors
the existing `feature_home` module's structure and conventions.

## Scope

- New feature only. `feature_home` is untouched.
- Full stack: domain, data, presentation (cubit + page), routing, DI, unit tests.
- No local caching (Hive) — JSONPlaceholder is a fake/demo API and responses aren't
  meant to persist (e.g. POST always returns `id: 101` regardless of what's sent).
  `feature_home`'s caching pattern is not needed here.
- Base URL: `https://jsonplaceholder.typicode.com` is set only on the new
  `PostRemoteDatasource` (via a `@Named('jsonPlaceholderBaseUrl')` DI value), leaving
  the app-wide `AppConstants.baseUrl` / `FlavorConfig` untouched. Retrofit's generated
  client applies this per-request via `.copyWith(baseUrl: ...)`, so it's safe to share
  the app's single `Dio` instance across datasources with different base URLs (verified
  against the generated `home_remote_datasource.g.dart`).

## Data Shape

JSONPlaceholder post JSON:
```json
{ "userId": 1, "id": 1, "title": "...", "body": "..." }
```

## Layers

### Domain (`domain/lib/feature_post/`)
- `entities/post_entity.dart` — `PostEntity { id, userId, title, body }`, immutable,
  `==`/`hashCode`/`copyWith`, matching `HomeEntity` conventions.
- `repositories/post_repository.dart` — abstract `PostRepository`:
  - `Future<Result<List<PostEntity>>> getPosts()`
  - `Future<Result<PostEntity>> getPost(int id)`
  - `Future<Result<PostEntity>> createPost(PostEntity post)`
  - `Future<Result<PostEntity>> updatePost(PostEntity post)` (PUT, full replace)
  - `Future<Result<PostEntity>> patchPost(int id, {String? title, String? body})` (PATCH, partial)
  - `Future<Result<void>> deletePost(int id)`
- `usecases/` — one class per operation (`GetPostsUseCase`, `GetPostUseCase`,
  `CreatePostUseCase`, `UpdatePostUseCase`, `PatchPostUseCase`, `DeletePostUseCase`),
  each `@injectable`, thin wrappers delegating to the repository — matching
  `GetHomeDataUseCase`'s pattern (no shared `UseCase<T, P>` base class exists in this
  codebase; don't introduce one).

### Data (`data/lib/feature_post/`)
- `models/post_model.dart` — `@freezed PostModel { id, userId, title, body }` with
  `fromJson`/`toJson` (via `json_serializable`) and `toEntity()` / `fromEntity()`
  conversion extensions, matching `HomeModel`.
- `datasources/post_remote_datasource.dart` — `@RestApi()` abstract class with a
  factory constructor `(Dio dio, {String baseUrl})`, one method per verb:
  - `@GET('/posts') Future<List<PostModel>> getPosts()`
  - `@GET('/posts/{id}') Future<PostModel> getPost(@Path('id') int id)`
  - `@POST('/posts') Future<PostModel> createPost(@Body() PostModel post)`
  - `@PUT('/posts/{id}') Future<PostModel> updatePost(@Path('id') int id, @Body() PostModel post)`
  - `@PATCH('/posts/{id}') Future<PostModel> patchPost(@Path('id') int id, @Body() Map<String, dynamic> body)`
  - `@DELETE('/posts/{id}') Future<void> deletePost(@Path('id') int id)`
- `repositories/post_repository_impl.dart` — implements `PostRepository`, delegates to
  the datasource, catches `DioException` → `NetworkFailure`, other exceptions →
  `UnknownFailure` (same try/catch shape as `HomeRepositoryImpl`, minus the cache
  branches).

### Presentation (`lib/feature_post/`)
- `cubit/post_cubit.dart` — `@freezed PostState` (`initial`, `loading`, `loaded(posts)`,
  `mutating` (create/update/patch/delete in flight), `error(message)`); `PostCubit`
  methods: `fetchPosts()`, `createPost(title, body)`, `updatePost(post)`,
  `patchPostTitle(id, title)`, `deletePost(id)` — after a successful mutation, refetch
  the list (JSONPlaceholder doesn't persist writes, so optimistic local mutation would
  be misleading; a refetch honestly shows the fake API's real behavior, which the UI
  will label as a demo).
- `pages/posts_page.dart` — list of posts with pull-to-refresh, a FAB to create a post
  (simple dialog with title/body fields), swipe-to-delete per item, and tap-to-edit
  (dialog reused for both PUT full-edit and a "quick patch title" affordance) so all
  four mutating verbs are reachable from the UI, plus GET-all and GET-by-id (tapping
  navigates to a detail fetch). A small banner notes JSONPlaceholder is a fake API and
  writes won't persist across refresh.
- Route: `AppRoutes.posts = '/posts'` added to `app_routes.dart`, registered as a
  top-level `GoRoute` in `app_router.dart`, alongside the home route (not nested under
  it). No entry point link is added automatically to avoid touching `HomePage` layout;
  reachable via direct navigation/deep link — acceptable for this example feature.

### DI (`core/lib/utils/injection/di_module.dart` + `lib/src/injection/di.dart`)
- `di_module.dart`: add `@Named('jsonPlaceholderBaseUrl') String` provider and a
  `@lazySingleton PostRemoteDatasource getPostRemoteDatasource(Dio dio, @Named('jsonPlaceholderBaseUrl') String baseUrl)`
  factory, mirroring `getHomeRemoteDatasource`.
- `di.dart`: register `PostRepository` → `PostRepositoryImpl`, the six use cases, and
  `PostCubit` as a factory, mirroring the home registrations.
- Run `fvm flutter pub run build_runner build --delete-conflicting-outputs` after
  annotations are in place (regenerates `di_module.g.dart` / freezed / json / retrofit
  outputs).

## Error Handling

Follows the existing rule: no `try/catch` in domain/presentation; only the data-layer
repository implementation catches `DioException` and unexpected exceptions, mapping to
`AppFailure` subclasses. Cubit reads the `(data, error)` `Result` tuple and emits
`loaded`/`error` accordingly, same shape as `HomeCubit`.

## Testing

- `test/features/post/domain/usecases/*_test.dart` — one per use case, mockito mock of
  `PostRepository`, mirroring `get_home_detail_usecase_test.dart`.
- `test/features/post/domain/entities/post_entity_test.dart` — equality/copyWith,
  mirroring `home_entity_test.dart`.
- `test/features/post/data/models/post_model_test.dart` — JSON round-trip and
  `toEntity()`/`fromEntity()`, mirroring `home_model_test.dart`.
- `test/features/post/data/repositories/post_repository_impl_test.dart` — mocked
  datasource, verifies success mapping and `DioException` → `NetworkFailure` mapping.
- `test/features/post/presentation/cubit/post_cubit_test.dart` — `blocTest` covering
  fetch success/failure and one mutating flow (create → refetch).
- Verification: `fvm flutter analyze` and `fvm flutter test` must pass before this is
  considered done.

## Out of Scope

- No offline caching/Hive box for posts.
- No auth on JSONPlaceholder calls (it's a public fake API).
- No pagination/infinite scroll — JSONPlaceholder's `/posts` returns all 100 at once;
  the list just renders them directly.
- No home page UI changes or nav menu entry.
