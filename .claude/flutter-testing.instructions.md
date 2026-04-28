---
name: flutter-testing
description: "Use when: writing tests, improving test coverage, testing BLoCs/widgets, or debugging test failures. Ensures comprehensive test coverage and proper test patterns."
applyTo: ["test/**", "**/test/**"]
---

# Testing Guidelines

Comprehensive testing practices for the Flutter boilerplate.

## Test Structure

```
test/                          # Widget & integration tests
├── widget_test.dart
└── utils/
    └── test_utils.dart

core/test/                      # Core package tests
domain/test/                    # Domain layer tests
data/test/                      # Data layer tests
lib/features/my_feature/test/   # Feature-specific tests
```

## Test Hierarchy (Bottom-Up)

1. **Domain Tests** (entities, use cases) - No mocks needed
2. **Data Tests** (models, repositories, data sources) - Mock APIs
3. **Presentation Tests** (BLoCs, widgets) - Mock domain & data

## Unit Tests

### Testing Use Cases
```dart
// domain/usecases/my_usecase_test.dart
void main() {
  group('MyUseCase', () {
    late MockMyRepository mockRepository;
    late MyUseCase useCase;
    
    setUp(() {
      mockRepository = MockMyRepository();
      useCase = MyUseCase(mockRepository);
    });
    
    test('should get data from repository', () async {
      // Arrange
      final tData = TestData.myEntity;
      when(() => mockRepository.getData())
          .thenAnswer((_) async => Right(tData));
      
      // Act
      final result = await useCase(NoParams());
      
      // Assert
      expect(result, Right(tData));
      verify(() => mockRepository.getData()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
    
    test('should return failure when repository fails', () async {
      // Arrange
      final tFailure = ServerFailure();
      when(() => mockRepository.getData())
          .thenAnswer((_) async => Left(tFailure));
      
      // Act
      final result = await useCase(NoParams());
      
      // Assert
      expect(result, Left(tFailure));
    });
  });
}
```

### Testing Repositories
```dart
// data/repositories/my_repository_impl_test.dart
void main() {
  group('MyRepositoryImpl', () {
    late MockMyRemoteDataSource mockRemoteDataSource;
    late MyRepositoryImpl repository;
    
    setUp(() {
      mockRemoteDataSource = MockMyRemoteDataSource();
      repository = MyRepositoryImpl(remoteDatasource: mockRemoteDataSource);
    });
    
    group('getData', () {
      test('should return remote data', () async {
        // Arrange
        final tModel = const MyModel(id: '1', name: 'Test');
        when(() => mockRemoteDataSource.getData())
            .thenAnswer((_) async => [tModel]);
        
        // Act
        final result = await repository.getData();
        
        // Assert
        expect(result, Right([tModel]));
      });
      
      test('should return failure on exception', () async {
        // Arrange
        when(() => mockRemoteDataSource.getData())
            .thenThrow(SocketException('Network error'));
        
        // Act
        final result = await repository.getData();
        
        // Assert
        expect(result, isA<Left>());
      });
    });
  });
}
```

## BLoC Tests

### Using bloc_test Package
```dart
// presentation/bloc/my_bloc_test.dart
void main() {
  group('MyBloc', () {
    late MockGetMyDataUseCase mockGetMyDataUseCase;
    late MyBloc myBloc;
    
    setUp(() {
      mockGetMyDataUseCase = MockGetMyDataUseCase();
      myBloc = MyBloc(getMyDataUseCase: mockGetMyDataUseCase);
    });
    
    tearDown(() {
      myBloc.close();
    });
    
    test('initial state is MyInitial', () {
      expect(myBloc.state, MyInitial());
    });
    
    blocTest<MyBloc, MyState>(
      'emits [Loading, Success] when LoadEvent succeeds',
      build: () {
        final tData = [TestData.myEntity];
        when(() => mockGetMyDataUseCase(any()))
            .thenAnswer((_) async => Right(tData));
        return myBloc;
      },
      act: (bloc) => bloc.add(const LoadMyDataEvent()),
      expect: () => [
        const MyLoading(),
        MySuccess(TestData.myDataList),
      ],
    );
    
    blocTest<MyBloc, MyState>(
      'emits [Loading, Failure] when LoadEvent fails',
      build: () {
        when(() => mockGetMyDataUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return myBloc;
      },
      act: (bloc) => bloc.add(const LoadMyDataEvent()),
      expect: () => [
        const MyLoading(),
        const MyFailure('Server error'),
      ],
    );
  });
}
```

## Widget Tests

### Testing Pages/Widgets
```dart
// presentation/pages/my_page_test.dart
void main() {
  group('MyPage', () {
    late MockMyBloc mockMyBloc;
    
    setUp(() {
      mockMyBloc = MockMyBloc();
    });
    
    testWidgets('displays loading indicator', (WidgetTester tester) async {
      // Arrange
      when(() => mockMyBloc.state).thenReturn(const MyLoading());
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MyBloc>.value(
            value: mockMyBloc,
            child: const MyPage(),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    
    testWidgets('displays data when state is Success',
        (WidgetTester tester) async {
      // Arrange
      final tData = [TestData.myEntity];
      when(() => mockMyBloc.state).thenReturn(MySuccess(tData));
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MyBloc>.value(
            value: mockMyBloc,
            child: const MyPage(),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });
  });
}
```

## Test Data & Fixtures

Create reusable test data:

```dart
// test/utils/test_utils.dart
class TestData {
  static const myEntity = MyEntity(
    id: '1',
    name: 'Test Name',
  );
  
  static const myModel = MyModel(
    id: '1',
    name: 'Test Name',
  );
  
  static final myDataList = [myEntity, myEntity];
  
  static Map<String, dynamic> myJson() => {
    'id': '1',
    'name': 'Test Name',
  };
}
```

## Mocking with Mocktail

### Create Mocks
```dart
// Create file: test/mocks/mock_repositories.dart
class MockMyRepository extends Mock implements MyRepository {}
class MockMyUseCase extends Mock implements MyUseCase {}
class MockMyBloc extends Mock implements MyBloc {}

// Auto-generate (recommended)
// Use mockito or mocktail with build_runner
```

### Mock Setup
```dart
setUp(() {
  mockRepo = MockMyRepository();
  // Stub methods
  when(() => mockRepo.getData())
      .thenAnswer((_) async => Right(data));
});
```

## Testing Best Practices

### Do's ✅
- Write tests for critical business logic first
- Use descriptive test names
- Follow Arrange-Act-Assert pattern
- Test one thing per test
- Use test fixtures for consistency
- Mock external dependencies
- Verify interactions (verify, verifyNoMoreInteractions)
- Test edge cases and error paths

### Don'ts ❌
- Don't test implementation details
- Don't mix multiple concerns in one test
- Don't make tests dependent on each other
- Don't test third-party libraries
- Don't ignore flaky tests
- Don't test everything equally

## Running Tests

```bash
# Run all tests
fvm flutter test

# Run tests in verbose mode
fvm flutter test --verbose

# Run specific file
fvm flutter test test/widget_test.dart

# Run with coverage
fvm flutter test --coverage

# Run matching pattern
fvm flutter test --name="should"

# Stop on first failure
fvm flutter test -x
```

## Coverage Goals

- **Domain layer**: 80%+ coverage
- **Data layer**: 70%+ coverage
- **Presentation layer**: 60%+ coverage
- **Overall**: Minimum 70% for new code

## Test Naming Convention

Use descriptive names:

✅ **Good:**
- `should_return_success_when_data_is_valid`
- `emits_loading_then_success_when_fetch_succeeds`
- `displays_error_message_on_failure`

❌ **Bad:**
- `test1`
- `testSuccess`
- `dataTest`

## Debugging Tests

```dart
// Print debug info
test('my test', () {
  debugPrint('Debug message: $variable');
  expect(value, expected);
});

// Use tester.pump for timing issues
await tester.pump();
await tester.pump(Duration(milliseconds: 500));

// Find by key
expect(find.byKey(Key('myWidget')), findsOneWidget);

// Get widget
final widget = find.byType(Text);
expect(widget, findsOneWidget);
```

## Continuous Integration

Tests run automatically on:
- Pull requests
- Main branch commits
- Scheduled daily runs

Check status in GitHub Actions.

