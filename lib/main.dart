import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/error_boundary/error_boundary_export.dart';
import 'package:flutter_boilerplate/routes/app_router.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor from --dart-define=FLAVOR={dev|staging|prod}.
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  FlavorConfig.instance = switch (flavor) {
    'staging' => FlavorConfig.staging(),
    'prod' => FlavorConfig.prod(),
    _ => FlavorConfig.dev(),
  };

  // Set bloc observer for debugging
  Bloc.observer = SimpleBlocObserver();

  // Initialize dependency injection
  // This also initializes Hive and pre-resolves SharedPreferences
  await di.configureDependencies();

  runApp(const MyApp());
}

/// Main app widget
class MyApp extends StatelessWidget {
  /// Main app widget
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      onError: (error, stackTrace) {
        debugPrint('Uncaught error: $error\n$stackTrace');
      },
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: FlavorConfig.instance.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            // Reference design (image #4) is light, so pin to light.
            themeMode: ThemeMode.light,
            // Hide the red "DEBUG" ribbon in the top-right corner even
            // for debug builds — it crowds the AppBar in the real-app
            // screenshots and adds no value once you're inside the app.
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.getRouter(
              isLoggedIn: () async {
                final (token, _) = await di.getIt<LocalStorage>()
                    .get<String>('auth_token');
                return token != null && token.isNotEmpty;
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
          );
        },
      ),
    );
  }
}
