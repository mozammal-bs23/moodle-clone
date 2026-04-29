import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
import 'package:flutter_boilerplate_core/utils/storage/local_storage.dart';
import 'package:flutter_boilerplate_core/utils/network/result.dart';
import 'package:flutter_boilerplate/routes/app_router.dart';
import 'package:flutter_boilerplate_core/utils/theme/app_theme.dart';
import 'package:flutter_boilerplate_core/utils/bloc_observer.dart';

/// Helper function to pump the app with optional dependency overrides
Future<void> pumpApp(
  WidgetTester tester, {
  Widget? overrideWidget,
  Map<Type, dynamic>? overrides,
}) async {
  // Reset GetIt to ensure clean state for each test
  GetIt.instance.reset();

  // Apply overrides if provided
  if (overrides != null) {
    overrides.forEach((type, implementation) {
      GetIt.instance.registerSingleton(type, implementation);
    });
  }

  // Configure dependencies if not overridden
  if (overrides == null || !overrides.containsKey(di.sl)) {
    await di.configureDependencies();
    await GetIt.instance<LocalStorage>().init();
  }

  // Set bloc observer
  Bloc.observer = SimpleBlocObserver();

  // Build the app
  final widget = overrideWidget ??
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocProvider(
            create: (_) => GetIt.instance<di.sl>(),
            child: MaterialApp.router(
              title: 'Flutter Boilerplate',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.system,
              routerConfig: AppRouter.getRouter(
                isLoggedIn: () async {
                  final result = await GetIt.instance<LocalStorage>()
                      .get<String>('auth_token');
                  return result.when(
                    success: (token) => token != null && token.isNotEmpty,
                    failure: (_) => false,
                  );
                },
              ),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.noScaling,
                  ),
                  child: child!,
                );
              },
            ),
          );
        },
      );

  await tester.pumpWidget(widget);
  await tester.pumpAndSettle();
}

/// Creates a mock LocalStorage instance
MockLocalStorage createMockLocalStorage() {
  return MockLocalStorage();
}

/// Base class for all mocks
class MockBase extends Mock {}

/// Mock for LocalStorage
class MockLocalStorage extends MockBase implements LocalStorage {
  @override
  Future<void> init() async => super.init();

  @override
  Future<Result<T>> get<T>(String key) => super.get<T>(key);

  @override
  Future<Result<void>> set<T>(String key, T value) =>
      super.set<T>(key, value);

  @override
  Future<Result<void>> remove(String key) => super.remove(key);

  @override
  Future<Result<void>> clear() => super.clear();

  @override
  Future<Result<bool>> containsKey(String key) =>
      super.containsKey(key);
}

/// Mock for ApiClient
class MockApiClient extends MockBase implements ApiClient {
  @override
  Dio get dio => super.dio;
}

/// Mock for Logger
class MockLogger extends MockBase implements Logger {
  @override
  Level get level => super.level;

  @override
  set level(Level value) => super.level = value;

  @override
  LogPrinter get printer => super.printer;

  @override
  set printer(LogPrinter value) => super.printer = value;

  @override
  void log(Level level, dynamic message, [Error? error, StackTrace? stackTrace]) =>
      super.log(level, message, error, stackTrace);

  @override
  void verbose(dynamic message, [Error? error, StackTrace? stackTrace]) =>
      super.verbose(message, error, stackTrace);

  @override
  void debug(dynamic message, [Error? error, StackTrace? stackTrace]) =>
      super.debug(message, error, stackTrace);

  @override
  void info(dynamic message, [Error? error, StackTrace? stackTrace]) =>
      super.info(message, error, stackTrace);

  @override
  void warn(dynamic message, [Error? error, StackTrace? stackTrace]) =>
      super.warn(message, error, stackTrace);

  @override
  void error(dynamic message, [Error? error, StackTrace? stackTrace]) =>
      super.error(message, error, stackTrace);

  @override
  void wtf(dynamic message, [Error? error, StackTrace? stackTrace]) =>
      super.wtf(message, error, stackTrace);
}