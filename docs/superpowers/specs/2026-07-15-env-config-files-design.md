# Environment Config Files — Design

## Problem

The app already has a `Flavor` enum (`dev`/`staging`/`prod`) and a `FlavorConfig`
class (`core/lib/utils/flavor/flavor_config.dart`) whose factories hardcode
`appName` and `baseUrl` per flavor. There is no `env/` folder and no mechanism
to override these values without editing and recompiling Dart source.

## Goal

Add an `env/` folder with one JSON file per environment, and wire
`FlavorConfig` to read its values from those files via
`--dart-define-from-file`, while preserving current hardcoded values as
defaults so existing run commands keep working unchanged.

## Design

### 1. `env/` folder (repo root, sibling to `lib/`, `core/`, `data/`, `domain/`)

Three files, one per environment, each defining two keys that mirror what
`FlavorConfig` already hardcodes today:

`env/dev.json`
```json
{
  "APP_NAME": "Flutter Boilerplate Dev",
  "BASE_URL": "https://api-dev.example.com"
}
```

`env/staging.json`
```json
{
  "APP_NAME": "Flutter Boilerplate Staging",
  "BASE_URL": "https://api-staging.example.com"
}
```

`env/prod.json`
```json
{
  "APP_NAME": "Flutter Boilerplate",
  "BASE_URL": "https://api.example.com"
}
```

These contain no secrets, so they are committed to git as-is.

### 2. Wire `FlavorConfig` to read them

`core/lib/utils/flavor/flavor_config.dart` factories change from hardcoded
string literals to `String.fromEnvironment(...)` reads, defaulting to
today's hardcoded value:

```dart
factory FlavorConfig.dev() => FlavorConfig._(
  flavor: Flavor.dev,
  appName: const String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Flutter Boilerplate Dev',
  ),
  baseUrl: const String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api-dev.example.com',
  ),
);
```

Same pattern for `staging()` and `prod()`, each defaulting to its own current
hardcoded value. Because the default equals today's value, omitting
`--dart-define-from-file` leaves behavior unchanged — this is non-breaking.

### 3. Documentation

Update the "App Flavors (Environments)" section of `README.md`:
- Remove the "No `--dart-define` needed" claim (no longer accurate).
- Show the new run commands with `--dart-define-from-file`:
  ```bash
  fvm flutter run -t lib/main_dev.dart --dart-define-from-file=env/dev.json
  fvm flutter run -t lib/main_staging.dart --dart-define-from-file=env/staging.json
  fvm flutter run -t lib/main_prod.dart --dart-define-from-file=env/prod.json
  ```
- Note that omitting the flag falls back to the same hardcoded defaults as
  before.

## Out of scope

- Android `productFlavors` (`android/app/build.gradle.kts`) and iOS
  `.xcconfig` files are untouched — this design only affects Dart-level
  `APP_NAME`/`BASE_URL` resolution, not native build flavors.
- No new package dependency (uses Dart's built-in
  `String.fromEnvironment`).
- No secrets management — current values are non-sensitive URLs/names. If
  real secrets are needed later, that's a separate design (e.g. gitignored
  files + `.example` templates).

## Testing

No existing tests reference `FlavorConfig` values, so no test changes are
required. Verification is `fvm flutter analyze` plus manually confirming
(by the user) that `fvm flutter run -t lib/main_dev.dart
--dart-define-from-file=env/dev.json` picks up the JSON values.
