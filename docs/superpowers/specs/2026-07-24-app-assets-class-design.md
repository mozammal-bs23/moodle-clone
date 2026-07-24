# App Assets Class — Design

## Problem

There is no `assets/` folder in the project, no `assets:` section in the root
`pubspec.yaml`, and no centralized place for asset path strings. Any asset
paths added to widgets today would be hardcoded string literals scattered
across feature code.

## Goal

Scaffold the asset folder structure and pubspec wiring, and add a single
`AppAssets` class holding asset path constants — following the same
convention already established by `AppConstants` in
`core/lib/utils/constants/app_constants.dart` — so future asset additions
have one place to register a path and one place to reference it from.

This is scaffolding only: no real image/icon files exist yet, so the class
holds path-prefix constants and empty category sections, not fabricated
filenames.

## Design

### 1. Asset folders (repo root, sibling to `lib/`, `core/`, `data/`, `domain/`)

```
assets/
├── images/
│   └── .gitkeep
└── icons/
    └── .gitkeep
```

`.gitkeep` files exist only so git tracks the otherwise-empty directories;
remove them once real assets land.

### 2. `pubspec.yaml` wiring

Add an `assets:` section under `flutter:` in the root `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
```

### 3. `AppAssets` class

New file: `core/lib/utils/constants/app_assets.dart`

```dart
/// Centralized asset path constants.
///
/// Add a `static const String` entry here for each new asset, grouped
/// under the matching `// Images` / `// Icons` comment section.
class AppAssets {
  const AppAssets._();

  static const String imagesPath = 'assets/images';
  static const String iconsPath = 'assets/icons';

  // Images

  // Icons
}
```

Future entries follow the pattern `static const String logo =
'$imagesPath/logo.png';` placed under the matching comment section.

### 4. Barrel export

`core/lib/flutter_boilerplate_core.dart` already exports
`utils/constants/app_constants.dart` under a `// Constants` comment. Add:

```dart
export 'utils/constants/app_assets.dart';
```

next to the existing constants export, so consumers get it via the single
`flutter_boilerplate_core` package import like every other core utility.

## Out of scope

- No real asset files (images/icons) are added in this change — only the
  folder scaffold and the empty-but-ready `AppAssets` class.
- No code generation (e.g. `flutter_gen`) — matches the boilerplate's
  existing hand-maintained-constants convention (`AppConstants`,
  `AppSpacing`, `AppSize`).
- No font assets — not requested; add a `fonts:` section and matching
  constants separately if/when needed.

## Testing

No logic to unit test — this is static data. Verification is `fvm flutter
analyze` (confirms the new file compiles and the barrel export resolves)
and `fvm flutter pub get` (confirms the `assets:` section in `pubspec.yaml`
is valid and the referenced folders exist).
