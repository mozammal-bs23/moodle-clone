# Environment Config Files Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add an `env/` folder with per-environment JSON files and wire the existing `FlavorConfig` class to read `APP_NAME`/`BASE_URL` from them via `--dart-define-from-file`, without changing behavior when the flag is omitted.

**Architecture:** Three static JSON files (`env/dev.json`, `env/staging.json`, `env/prod.json`) hold `APP_NAME`/`BASE_URL` per environment. `FlavorConfig` factories in the `core` package switch from hardcoded string literals to `String.fromEnvironment(key, defaultValue: <current hardcoded value>)`, so the JSON values only take effect when `--dart-define-from-file` is passed at run/build time; otherwise behavior is identical to today.

**Tech Stack:** Flutter (FVM-pinned 3.41.8), Dart `String.fromEnvironment` (built-in, no new dependency), `flutter_test` (already a dev dependency of the `core` package).

## Global Constraints

- Use `fvm flutter ...` for all Flutter/Dart commands, never bare `flutter` (per project CLAUDE.md).
- No new pub dependencies.
- JSON files contain no secrets — they are committed to git as-is.
- Omitting `--dart-define-from-file` must preserve exactly today's hardcoded `appName`/`baseUrl` values per flavor (non-breaking default).
- Reference spec: `docs/superpowers/specs/2026-07-15-env-config-files-design.md`

---

### Task 1: Create the `env/` folder with per-environment JSON files

**Files:**
- Create: `env/dev.json`
- Create: `env/staging.json`
- Create: `env/prod.json`

**Interfaces:**
- Produces: three JSON files at repo root, each with exactly two string keys, `APP_NAME` and `BASE_URL`. Task 2 consumes these key names (`APP_NAME`, `BASE_URL`) in `String.fromEnvironment` calls.

- [ ] **Step 1: Create `env/dev.json`**

```json
{
  "APP_NAME": "Flutter Boilerplate Dev",
  "BASE_URL": "https://api-dev.example.com"
}
```

- [ ] **Step 2: Create `env/staging.json`**

```json
{
  "APP_NAME": "Flutter Boilerplate Staging",
  "BASE_URL": "https://api-staging.example.com"
}
```

- [ ] **Step 3: Create `env/prod.json`**

```json
{
  "APP_NAME": "Flutter Boilerplate",
  "BASE_URL": "https://api.example.com"
}
```

- [ ] **Step 4: Validate all three files are syntactically valid JSON**

Run:
```bash
python3 -c "import json; [json.load(open(f'env/{f}.json')) for f in ['dev','staging','prod']]; print('all valid')"
```
Expected output: `all valid`

- [ ] **Step 5: Commit**

```bash
git add env/dev.json env/staging.json env/prod.json
git commit -m "feat: add per-environment config JSON files"
```

---

### Task 2: Wire `FlavorConfig` to read from the environment files, update docs

**Files:**
- Modify: `core/lib/utils/flavor/flavor_config.dart`
- Test: `test/utils/flavor/flavor_config_test.dart` (new file — this repo puts all tests for path-dependency packages like `core` under the root `test/` directory, e.g. `test/core/error_boundary/...` and `test/utils/test_utils.dart`, never inside `core/test/`)
- Modify: `README.md:240-258` (the "App Flavors (Environments) — Already Implemented" section)

**Interfaces:**
- Consumes: `env/dev.json` keys `APP_NAME`/`BASE_URL` from Task 1 (via `--dart-define-from-file` at run time, not read directly by Dart code).
- Produces: `FlavorConfig.dev()`, `FlavorConfig.staging()`, `FlavorConfig.prod()` unchanged in signature; `appName`/`baseUrl` values now sourced from compile-time environment with the current hardcoded strings as defaults.

- [ ] **Step 1: Write the regression test (guards non-breaking default behavior)**

Create `test/utils/flavor/flavor_config_test.dart`:

```dart
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlavorConfig', () {
    test('dev() defaults match the pre-existing hardcoded values', () {
      final config = FlavorConfig.dev();
      expect(config.flavor, Flavor.dev);
      expect(config.appName, 'Flutter Boilerplate Dev');
      expect(config.baseUrl, 'https://api-dev.example.com');
      expect(config.isDev, isTrue);
    });

    test('staging() defaults match the pre-existing hardcoded values', () {
      final config = FlavorConfig.staging();
      expect(config.flavor, Flavor.staging);
      expect(config.appName, 'Flutter Boilerplate Staging');
      expect(config.baseUrl, 'https://api-staging.example.com');
      expect(config.isStaging, isTrue);
    });

    test('prod() defaults match the pre-existing hardcoded values', () {
      final config = FlavorConfig.prod();
      expect(config.flavor, Flavor.prod);
      expect(config.appName, 'Flutter Boilerplate');
      expect(config.baseUrl, 'https://api.example.com');
      expect(config.isProd, isTrue);
    });
  });
}
```

- [ ] **Step 2: Run the test to verify it passes against the current (pre-refactor) code**

Run: `fvm flutter test test/utils/flavor/flavor_config_test.dart`
Expected: `00:0X +3: All tests passed!`

This confirms the test correctly characterizes today's behavior before the refactor, so it will catch any regression the refactor introduces.

- [ ] **Step 3: Refactor `FlavorConfig` factories to read from compile-time environment**

Replace the contents of `core/lib/utils/flavor/flavor_config.dart`:

```dart
/// Supported app flavors
enum Flavor {
  /// Development environment
  dev,

  /// Staging environment
  staging,

  /// Production environment
  prod,
}

/// Global flavor configuration for the app
class FlavorConfig {
  FlavorConfig._({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
  });

  /// Creates dev flavor configuration.
  ///
  /// Reads `APP_NAME`/`BASE_URL` from the compile-time environment
  /// (pass `--dart-define-from-file=env/dev.json` to override), falling
  /// back to the values below when the flag is omitted.
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

  /// Creates staging flavor configuration.
  ///
  /// Reads `APP_NAME`/`BASE_URL` from the compile-time environment
  /// (pass `--dart-define-from-file=env/staging.json` to override), falling
  /// back to the values below when the flag is omitted.
  factory FlavorConfig.staging() => FlavorConfig._(
    flavor: Flavor.staging,
    appName: const String.fromEnvironment(
      'APP_NAME',
      defaultValue: 'Flutter Boilerplate Staging',
    ),
    baseUrl: const String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://api-staging.example.com',
    ),
  );

  /// Creates production flavor configuration.
  ///
  /// Reads `APP_NAME`/`BASE_URL` from the compile-time environment
  /// (pass `--dart-define-from-file=env/prod.json` to override), falling
  /// back to the values below when the flag is omitted.
  factory FlavorConfig.prod() => FlavorConfig._(
    flavor: Flavor.prod,
    appName: const String.fromEnvironment(
      'APP_NAME',
      defaultValue: 'Flutter Boilerplate',
    ),
    baseUrl: const String.fromEnvironment(
      'BASE_URL',
      defaultValue: 'https://api.example.com',
    ),
  );

  /// Singleton instance of FlavorConfig
  static late FlavorConfig instance;

  /// Current flavor
  final Flavor flavor;

  /// App display name for the current flavor
  final String appName;

  /// API base URL for the current flavor
  final String baseUrl;

  /// Returns true if current flavor is dev
  bool get isDev => flavor == Flavor.dev;

  /// Returns true if current flavor is staging
  bool get isStaging => flavor == Flavor.staging;

  /// Returns true if current flavor is prod
  bool get isProd => flavor == Flavor.prod;
}
```

- [ ] **Step 4: Run the test again to verify it still passes post-refactor**

Run: `fvm flutter test test/utils/flavor/flavor_config_test.dart`
Expected: `00:0X +3: All tests passed!`

- [ ] **Step 5: Update the README "App Flavors" section**

In `README.md`, replace the block currently at lines 240-258:

```markdown
### App Flavors (Environments) — Already Implemented ✅

Three entry points preconfigured: dev, staging, prod.

```bash
# Dev environment (hot reload, verbose logging, test API)
fvm flutter run -t lib/main_dev.dart

# Staging (integration tests, staging API, analytics)
fvm flutter run -t lib/main_staging.dart

# Production (release mode, prod API, full analytics)
fvm flutter run -t lib/main_prod.dart
```

Configuration stored in `core/lib/utils/flavor/flavor_config.dart`:
- Each flavor has custom app name, baseUrl, feature flags
- Configured automatically via entry point selection
- No `--dart-define` needed — type-safe enum-based setup
```

with:

```markdown
### App Flavors (Environments) — Already Implemented ✅

Three entry points preconfigured: dev, staging, prod. Each has a matching
JSON file under `env/` that supplies `APP_NAME`/`BASE_URL` at build time.

```bash
# Dev environment (hot reload, verbose logging, test API)
fvm flutter run -t lib/main_dev.dart --dart-define-from-file=env/dev.json

# Staging (integration tests, staging API, analytics)
fvm flutter run -t lib/main_staging.dart --dart-define-from-file=env/staging.json

# Production (release mode, prod API, full analytics)
fvm flutter run -t lib/main_prod.dart --dart-define-from-file=env/prod.json
```

Configuration stored in `core/lib/utils/flavor/flavor_config.dart`:
- Each flavor reads `APP_NAME`/`BASE_URL` from the compile-time environment
  (`env/dev.json`, `env/staging.json`, `env/prod.json`)
- Omitting `--dart-define-from-file` falls back to the same hardcoded
  defaults as before — existing commands without the flag still work
```

- [ ] **Step 6: Run static analysis across the workspace**

Run: `fvm flutter analyze`
Expected: `No issues found!`

- [ ] **Step 7: Commit**

```bash
git add core/lib/utils/flavor/flavor_config.dart test/utils/flavor/flavor_config_test.dart README.md
git commit -m "feat: read FlavorConfig values from --dart-define-from-file env JSON"
```

---

## Manual Verification (not automated — do after both tasks)

Confirm the override path actually works end-to-end (the automated test only
covers the no-flag default path, per the design's testing section):

```bash
fvm flutter run -t lib/main_dev.dart --dart-define-from-file=env/dev.json
```

Expected: app launches with title "Flutter Boilerplate Dev" (unchanged from
today, since `env/dev.json` mirrors the default) — confirms the plumbing
works without changing observable behavior.
