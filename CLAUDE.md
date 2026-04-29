# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**flutter_boilerplate** is a production-ready Flutter application using Clean Architecture with feature-based organization. It demonstrates best practices for state management (BLoC), dependency injection, networking, and local storage.

**Key Stack:**
- **Flutter 3.41.8** (managed by FVM in `.fvmrc`)
- **State Management:** BLoC 7.x + Cubit
- **Architecture:** Clean Architecture (presentation/domain/data layers)
- **Dependency Injection:** GetIt + Injectable
- **Networking:** Dio + Retrofit
- **Local Storage:** Hive + SharedPreferences
- **Navigation:** go_router with auth guards
- **Code Generation:** build_runner, freezed, json_serializable

## Project Structure

### Monorepo Organization

The project uses a monorepo structure with separate packages:

```
flutter_boilerplate/           # Main app
├── lib/
│   ├── main.dart              # Entry point
│   ├── feature_home/          # Feature (presentation layer only)
│   │   ├── cubit/            # BLoC/Cubit for state management
│   │   ├── pages/            # Full-screen widgets
│   │   └── widgets/          # Reusable components
│   ├── routes/               # Navigation config (go_router)
│   └── src/
│       ├── injection/        # DI setup wrapper
│       └── ...
│
├── core/                      # Shared utilities package
│   ├── lib/utils/
│   │   ├── network/          # HTTP client, interceptors (dio)
│   │   ├── storage/          # Local storage wrappers
│   │   ├── theme/            # App theme & styles
│   │   ├── failure/          # Error handling (sealed classes)
│   │   ├── injection/        # DI configuration
│   │   └── logger/           # Logging setup
│   └── pubspec.yaml
│
├── domain/                    # Business logic package
│   └── feature_home/
│       ├── entities/         # Data models
│       ├── repositories/     # Abstract interfaces
│       └── usecases/         # Business logic
│
├── data/                      # Data access package
│   └── feature_home/
│       ├── datasources/      # Remote/local data sources
│       ├── models/           # JSON models
│       └── repositories/     # Concrete implementations
│
└── test/                      # Shared test utilities
```

### Architecture Layers

**Domain Layer** (`domain/` package)
- Pure business logic, no dependencies on Flutter
- Entities: immutable data models
- Repository interfaces: abstract contracts
- Use cases: single responsibility business operations
- Returns `Future<Either<Failure, T>>` using the `Result` pattern

**Data Layer** (`data/` package)
- Implements domain repositories
- Data sources: remote (Dio) and local (Hive/SharedPreferences)
- Models: extend entities with JSON serialization
- Handles error-to-failure mapping

**Presentation Layer** (`lib/feature_*/`)
- BLoC/Cubit for state management
- Pages: full-screen widgets with BlocProvider
- Widgets: reusable UI components
- UI state sealed classes (Loading/Success/Failure)

**Core Layer** (`core/` package)
- Shared utilities across layers
- Network setup: interceptors, clients, serialization
- Storage: Hive, SharedPreferences wrappers
- Theme, constants, extensions, failure types
- Dependency injection configuration

## Essential Commands

**Always use FVM** — never run `flutter` directly:

```bash
# Get dependencies (run after changes to pubspec.yaml)
fvm flutter pub get

# Format code
fvm flutter format .

# Analyze for type/lint issues
fvm flutter analyze

# Run tests
fvm flutter test                          # All tests
fvm flutter test test/features/home/      # Single directory
fvm flutter test -x                       # Stop on first failure
fvm flutter test --coverage               # Generate coverage report

# Run app
fvm flutter run                           # Debug
fvm flutter run --release                 # Release mode
fvm flutter run -d web                    # Web platform

# Build for release
fvm flutter build apk --release           # Android APK
fvm flutter build appbundle --release     # Android App Bundle
fvm flutter build ios --release           # iOS
fvm flutter build web --release           # Web

# Code generation (run after modifying models, freezed, json_serializable)
fvm flutter pub run build_runner build        # Build once
fvm flutter pub run build_runner watch       # Watch for changes
fvm flutter pub run build_runner clean       # Remove generated files

# Before committing
fvm flutter format .
fvm flutter analyze
fvm flutter test
```

## Feature Development Workflow

Each feature follows Clean Architecture with three packages:

### 1. Domain Layer (`domain/lib/feature_X/`)

**Entity** — Immutable data model:
```dart
class MyEntity extends Equatable {
  final String id;
  const MyEntity({required this.id});
  @override
  List<Object?> get props => [id];
}
```

**Repository Interface** — Abstract contract:
```dart
abstract class MyRepository {
  Future<Either<Failure, MyEntity>> getData();
}
```

**Use Case** — Single business operation:
```dart
class GetDataUseCase extends UseCase<MyEntity, NoParams> {
  final MyRepository repository;
  GetDataUseCase(this.repository);
  
  @override
  Future<Either<Failure, MyEntity>> call(NoParams params) =>
    repository.getData();
}
```

### 2. Data Layer (`data/lib/feature_X/`)

**Model** — Extends entity with JSON serialization:
```dart
class MyModel extends MyEntity {
  const MyModel({required String id}) : super(id: id);
  
  factory MyModel.fromJson(Map<String, dynamic> json) =>
    MyModel(id: json['id']);
  
  Map<String, dynamic> toJson() => {'id': id};
}
```

**Data Source** — Access remote/local data:
```dart
abstract class MyRemoteDataSource {
  Future<MyModel> getData();
}

class MyRemoteDataSourceImpl implements MyRemoteDataSource {
  final Dio dio;
  MyRemoteDataSourceImpl(this.dio);
  
  @override
  Future<MyModel> getData() async {
    final response = await dio.get('/api/data');
    return MyModel.fromJson(response.data);
  }
}
```

**Repository Implementation** — Bridges domain and data:
```dart
class MyRepositoryImpl implements MyRepository {
  final MyRemoteDataSource remoteDataSource;
  MyRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Failure, MyEntity>> getData() async {
    try {
      final data = await remoteDataSource.getData();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
```

### 3. Presentation Layer (`lib/feature_X/`)

**States** — UI outputs (sealed classes):
```dart
sealed class MyState extends Equatable {
  const MyState();
}

class MyInitial extends MyState {
  @override
  List<Object?> get props => [];
}

class MyLoading extends MyState {
  @override
  List<Object?> get props => [];
}

class MySuccess extends MyState {
  final MyEntity data;
  const MySuccess(this.data);
  @override
  List<Object?> get props => [data];
}

class MyFailure extends MyState {
  final String message;
  const MyFailure(this.message);
  @override
  List<Object?> get props => [message];
}
```

**Events** — User actions (sealed classes):
```dart
sealed class MyEvent extends Equatable {
  const MyEvent();
}

class MyLoadEvent extends MyEvent {
  const MyLoadEvent();
  @override
  List<Object?> get props => [];
}
```

**BLoC** — State machine:
```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  final GetDataUseCase getDataUseCase;
  
  MyBloc({required this.getDataUseCase}) : super(MyInitial()) {
    on<MyLoadEvent>(_onLoad);
  }
  
  Future<void> _onLoad(MyLoadEvent event, Emitter<MyState> emit) async {
    emit(MyLoading());
    final result = await getDataUseCase(NoParams());
    result.fold(
      (failure) => emit(MyFailure(failure.message)),
      (data) => emit(MySuccess(data)),
    );
  }
}
```

**Page** — Full-screen widget:
```dart
class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyBloc>()..add(MyLoadEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Feature')),
        body: BlocBuilder<MyBloc, MyState>(
          builder: (context, state) => switch (state) {
            MyLoading() => const Center(child: CircularProgressIndicator()),
            MySuccess(:final data) => ListView(
              children: [Text(data.id)],
            ),
            MyFailure(:final message) => Center(child: Text(message)),
            MyInitial() => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}
```

### 4. Dependency Injection Setup

Register in `core/lib/utils/injection/di.config.dart` (auto-generated by `injectable`):

```dart
@injectable
class MyRemoteDataSource implements MyRemoteDataSourceImpl {
  final Dio dio;
  MyRemoteDataSourceImpl(this.dio);
}

@Injectable()
class MyRepository implements MyRepositoryImpl {
  final MyRemoteDataSource remoteDataSource;
  MyRepositoryImpl({required this.remoteDataSource});
}

@injectable
GetDataUseCase getDataUseCase(MyRepository repository) =>
  GetDataUseCase(repository);

@injectable
MyBloc myBloc(GetDataUseCase useCase) =>
  MyBloc(getDataUseCase: useCase);
```

After updating `@injectable` annotations, run:
```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Key Patterns & Conventions

### Result Type (Either/Failure)
Use `Either<Failure, T>` for domain layer returns to represent success/failure without exceptions:

```dart
// Domain use case
Future<Either<Failure, List<Post>>> getPosts();

// In BLoC
result.fold(
  (failure) => emit(MyFailure(failure.message)),
  (posts) => emit(MySuccess(posts)),
);
```

Custom failure types live in `core/lib/utils/failure/`:
- `ServerFailure` — HTTP errors
- `CacheFailure` — Local storage errors
- `ValidationFailure` — Input validation
- Add domain-specific failures as needed

### Sealed Classes for Type Safety
Use sealed classes for events, states, and failures:
```dart
sealed class MyState extends Equatable { /* ... */ }

// Compiler ensures all cases handled in switch/if-else
```

### Equatable for Equality
Use `Equatable` for immutable data models to avoid manual `==` implementation:
```dart
class MyEntity extends Equatable {
  final String id;
  const MyEntity({required this.id});
  
  @override
  List<Object?> get props => [id];  // Compare by these props
}
```

### BLoC Stream Behavior
- Events are inputs (user actions)
- States are outputs (UI updates)
- Use `on<EventType>(_handler)` to map events → states
- Always emit initial state in constructor
- Use `Emitter` to emit multiple states in sequence

### Error Handling
Never use `try-catch` in domain/presentation layers when returning `Either`. Catch at data layer:

```dart
// ❌ Don't do this
Future<Either<Failure, T>> getData() async {
  try {
    return Right(await remoteDataSource.getData());
  } catch (e) {
    return Left(ServerFailure());
  }
}

// ✅ Do this in data layer, let domain be pure
@override
Future<Either<Failure, T>> getData() {
  try {
    return remoteDataSource.getData().then(Right.new);
  } catch (e) {
    return Left(ServerFailure()).asFuture;
  }
}
```

## Network & Storage

### Dio Configuration
Configured in `core/lib/utils/network/` with:
- **AuthInterceptor** — Adds Bearer tokens to requests
- **LoggingInterceptor** — Logs HTTP requests/responses
- **Retrofit** — Type-safe API clients (generate with `build_runner`)

### Local Storage
Access via `getIt<LocalStorage>()`:
```dart
final storage = getIt<LocalStorage>();

// Save
await storage.set('key', 'value');

// Retrieve
final (value, _) = await storage.get<String>('key');

// Delete
await storage.delete('key');
```

Persists to:
- **Hive** — Structured data (models)
- **SharedPreferences** — Simple key-value pairs

## Testing

Place tests in `test/` with matching structure:
```
test/
├── features/
│   └── home/
│       ├── domain/usecases/
│       ├── data/
│       └── presentation/cubits/
└── utils/
```

### Unit Test (Use Case)
```dart
void main() {
  group('GetDataUseCase', () {
    late MockMyRepository mockRepo;
    late GetDataUseCase useCase;
    
    setUp(() {
      mockRepo = MockMyRepository();
      useCase = GetDataUseCase(mockRepo);
    });
    
    test('should return data on success', () async {
      when(() => mockRepo.getData())
          .thenAnswer((_) async => Right(tData));
      
      final result = await useCase(NoParams());
      
      expect(result, Right(tData));
      verify(() => mockRepo.getData()).called(1);
    });
  });
}
```

### BLoC Test
```dart
void main() {
  group('MyBloc', () {
    late MockGetDataUseCase mockUseCase;
    late MyBloc bloc;
    
    setUp(() {
      mockUseCase = MockGetDataUseCase();
      bloc = MyBloc(getDataUseCase: mockUseCase);
    });
    
    blocTest<MyBloc, MyState>(
      'should emit [Loading, Success] on load',
      build: () {
        when(() => mockUseCase(NoParams()))
            .thenAnswer((_) async => Right(tData));
        return bloc;
      },
      act: (bloc) => bloc.add(MyLoadEvent()),
      expect: () => [MyLoading(), MySuccess(tData)],
    );
  });
}
```

### Widget Test
```dart
void main() {
  testWidgets('HomePage renders list', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<MyBloc>(
          create: (_) => mockBloc,
          child: const MyPage(),
        ),
      ),
    );
    
    expect(find.byType(ListView), findsOneWidget);
  });
}
```

Use `bloc_test` package for BLoC testing and `mocktail` for mocking.

## Code Generation

Several packages require code generation. After modifying these files, run:

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

Watches for changes and rebuilds automatically:
```bash
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

### Packages Using Code Generation

| File | Generator | Output |
|------|-----------|--------|
| `*.freezed.dart` | Freezed | Immutable value types |
| `*.g.dart` | json_serializable | JSON serialization |
| `*.config.dart` | injectable | DI registration |
| `*.retrofit.dart` | retrofit | Retrofit client |
| `*.hive.dart` | hive_generator | Hive adapters |

## Common Tasks

### Add a New Feature
```bash
# Use the create-feature skill (if available) or:
# 1. Create domain/lib/feature_x/ with entities, repositories, usecases
# 2. Create data/lib/feature_x/ with models, datasources, repository_impl
# 3. Create lib/feature_x/ with cubit, pages, widgets
# 4. Register in core DI (di.config.dart)
# 5. Add routes in lib/routes/app_router.dart

fvm flutter pub run build_runner build
fvm flutter analyze
fvm flutter test
```

### Fix Type Safety Issues
If you see warnings like "type arguments should be explicit", add `<dynamic>` or the specific type:

```dart
// ❌ Implicit dynamic
final response = await Dio().fetch(options);

// ✅ Explicit type
final response = await Dio().fetch<dynamic>(options);
```

### Update a Dependency
```bash
# Add new package
fvm flutter pub add package_name

# Update existing
fvm flutter pub upgrade package_name

# Update all
fvm flutter pub upgrade

# Then test
fvm flutter pub get
fvm flutter analyze
fvm flutter test
```

### Run Tests with Coverage
```bash
fvm flutter test --coverage
open coverage/lcov.html  # View report on macOS
```

### Clean Build Cache
```bash
fvm flutter clean
fvm flutter pub get
fvm flutter pub run build_runner clean
fvm flutter pub run build_runner build
```

## Debugging

### Enable Debug Logging
```dart
// In main.dart, before configureDependencies():
setLogLevel(Level.debug);
```

### BLoC Observer
`SimpleBlocObserver` logs all BLoC events/state changes. Check console output during `fvm flutter run`.

### Hot Reload
Press `r` in terminal during `fvm flutter run` to hot reload (preserves app state).
Press `R` to hot restart (restarts app, clears state).

### Slow Build?
Use `--split-debug-info` to speed up debug builds (slower startup):
```bash
fvm flutter run --split-debug-info
```

## Important Notes

### FVM is Required
This project pins Flutter to **3.41.8** in `.fvmrc`. Commands like `fvm flutter` respect this version; bare `flutter` might use a different version installed locally.

### Monorepo Structure
`core/`, `data/`, and `domain/` are separate packages referenced in main `pubspec.yaml` via path dependencies. Run `fvm flutter pub get` in root to sync all packages.

### Avoid These Patterns
- ❌ Accessing data layer directly from UI
- ❌ Circular dependencies between packages
- ❌ Using `BuildContext` across `await` boundaries
- ❌ Mutable state in entities/models
- ❌ Exception-based error handling in domain layer (use `Either<Failure, T>`)
- ❌ Calling `getIt` inside stateless widgets — use `BlocProvider` instead

### Good Practices
- ✅ Use sealed classes for exhaustive checks
- ✅ Use `Equatable` for value comparison
- ✅ Register factories (not singletons) for BLoCs
- ✅ Write tests for use cases and BLoCs
- ✅ Document complex business logic with doc comments
- ✅ Use meaningful names (prefer `LoadPostsEvent` over `Event1`)

## References

- **Flutter Docs:** https://flutter.dev
- **BLoC Pattern:** https://bloclibrary.dev
- **Effective Dart:** https://dart.dev/guides/language/effective-dart
- **FVM:** https://fvm.app
- **Clean Architecture:** https://resocoder.com/clean-architecture-tdd

For detailed file-level instructions, see `.claude/` directory:
- `flutter-feature-development.instructions.md` — Feature structure & BLoC patterns
- `flutter-build-files.instructions.md` — pubspec.yaml & build config
- `flutter-testing.instructions.md` — Testing patterns & mocking
- `copilot-instructions.md` — Project-wide conventions
