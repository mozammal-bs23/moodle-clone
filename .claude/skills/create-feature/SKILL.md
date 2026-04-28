---
name: create-feature
description: "Use when: creating a new feature module, scaffolding feature structure, setting up presentation/domain/data layers, or generating BLoC boilerplate. Automates directory creation, file generation, and dependency injection setup."
---

# Create Feature Skill

Quickly scaffold a new feature in the Flutter boilerplate following clean architecture.

## Usage

Ask the agent to create a feature:
- "Create a feature for notifications"
- "Add a payments feature"
- "Scaffold a new feature called 'reviews'"

## What This Skill Does

1. **Creates presentation layer** under `lib/features/{feature_name}/` with BLoC, pages, and widgets
2. **Creates domain layer** under `domain/lib/` with entities, repositories (interfaces), and use cases
3. **Creates data layer** under `data/lib/` with models, data sources, and repository implementations
4. **Creates core extensions** under `core/lib/` if needed (utilities, mappers, etc.)
5. **Generates BLoC files** with events, states, and bloc class
6. **Registers in dependency injection** container
7. **Adds routing** configuration
8. **Generates unit tests** for critical components

## Multi-Package Architecture

This boilerplate uses **separate packages** for each architectural layer:

| Layer | Location | Purpose |
|-------|----------|---------|
| **Presentation** | `lib/features/{feature}/presentation/` | UI widgets, pages, BLoC state management |
| **Domain** | `domain/lib/{feature}/` | Business logic, entities, repository interfaces, use cases |
| **Data** | `data/lib/{feature}/` | API/local data sources, models, repository implementations |
| **Core** | `core/lib/{feature}/` | Shared utilities, mappers, extensions (optional, if needed) |

Each layer is a separate Dart package with its own `pubspec.yaml` for dependency isolation.

## Generated Structure

```
lib/features/my_feature/
├── presentation/
│   ├── bloc/
│   │   ├── my_feature_bloc.dart
│   │   ├── my_feature_event.dart
│   │   └── my_feature_state.dart
│   ├── pages/
│   │   └── my_feature_page.dart
│   └── widgets/
│       └── .gitkeep

domain/lib/
└── my_feature/
    ├── entities/
    │   └── my_entity.dart
    ├── repositories/
    │   └── my_feature_repository.dart
    └── usecases/
        └── get_my_data_usecase.dart

data/lib/
└── my_feature/
    ├── datasources/
    │   ├── my_feature_local_datasource.dart
    │   └── my_feature_remote_datasource.dart
    ├── models/
    │   └── my_model.dart
    └── repositories/
        └── my_feature_repository_impl.dart

core/lib/ (if needed)
└── my_feature/
    ├── extensions/
    │   └── .gitkeep
    ├── mappers/
    │   └── .gitkeep
    └── utilities/
        └── .gitkeep

test/features/my_feature/
└── presentation/
    └── bloc/
        └── my_feature_bloc_test.dart

domain/test/
└── my_feature/
    ├── repositories/
    │   └── my_feature_repository_test.dart
    └── usecases/
        └── get_my_data_usecase_test.dart

data/test/
└── my_feature/
    ├── models/
    │   └── my_model_test.dart
    ├── datasources/
    │   └── my_feature_remote_datasource_test.dart
    └── repositories/
        └── my_feature_repository_impl_test.dart
```

## File Templates

All generated files include:
- Proper imports and package organization
- Null-safety compliant code
- Equatable integration for state comparison
- Comprehensive doc comments
- Test placeholders
- Dependency injection setup

## Command to Register

After feature creation, run:
```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
```

## Notes

- **Presentation Layer**: UI components and BLoC logic in `lib/features/{feature}/presentation/`
- **Domain Layer**: Business logic in `domain/lib/{feature}/` (interfaces, entities, use cases)
- **Data Layer**: API/local data sources in `data/lib/{feature}/` (models, repositories implementation)
- **Core Layer**: Shared utilities specific to features in `core/lib/{feature}/` (mappers, extensions)
- Always use **FVM** with flutter commands
- Follow **Effective Dart** style guide and clean architecture principles
- Keep features modular and independent with clear separation of concerns
- Use **BLoC pattern** for presentation layer state management
- Write tests for domain layer first, then data layer, then presentation
