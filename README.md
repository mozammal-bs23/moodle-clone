# flutter_boilerplate

A production-ready Flutter boilerplate with clean architecture.

## 🏆 Boilerplate Review Score: 18/20

### **Score Breakdown**

| Category | Score | Notes |
| :--- | :---: | :--- |
| **Architecture & Structure** | 4 / 4 | Excellent feature-based Clean Architecture. Separation of concerns is clear. |
| **State Management & DI** | 3 / 4 | BLoC/Cubit usage is solid. However, DI is inconsistent; manually registering features in `di.dart` instead of fully leveraging `@injectable`. |
| **Networking & Patterns** | 3 / 4 | `Result` and `AppFailure` patterns are modern and robust (sealed classes), but they aren't used in Repositories/Use Cases yet. |
| **Routing & Navigation** | 2 / 2 | Perfect `go_router` setup with auth guards and observers. |
| **Testing & Quality** | 2 / 4 | Lacks unit/widget tests for UseCases and Cubits. Lints are standard but could be stricter (e.g., `very_good_analysis`). |
| **Features & Tooling** | 4 / 4 | Great inclusion of `ScreenUtil`, `Hive`, `Shimmer`, and Theme support. |

---

### **Specific Recommendations**

1.  **Unify Dependency Injection**: 
    Use `@injectable` and `@factoryMethod` on Cubits, Use Cases, and Repositories to let `build_runner` handle the wiring automatically in `lib/src/injection/di.dart`.

2.  **Consistent `Result` Pattern**: 
    Transition Repositories and Use Cases to return `Future<Result<Entity>>`. This allows Cubits to use `.when()` or `fold()` on the result, removing the need for `try-catch` blocks in the UI layer.

3.  **Clean up Root Directories**: 
    The `core/`, `data/`, and `domain/` directories at the project root appear to be separate packages but aren't linked in the main `pubspec.yaml`. If not using a monorepo tool like Melos, these should be consolidated or removed.

4.  **Add Testing Examples**: 
    Add mock-based unit tests for a `Cubit` (using `bloc_test`) and a `UseCase` to provide a complete pattern for other developers.

5.  **Strict Linting**: 
    Consider switching from `flutter_lints` to `very_good_analysis` for stricter enforcement of best practices and type safety.

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
