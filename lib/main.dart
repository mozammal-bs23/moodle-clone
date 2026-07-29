import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/core/error_boundary/error_boundary_export.dart';
import 'package:flutter_boilerplate/routes/app_router.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 1. Initialize Flavor
    try {
      FlavorConfig.instance;
    } catch (_) {
      FlavorConfig.instance = FlavorConfig.dev();
    }

    // 2. Initialize Dependency Injection
    await di.configureDependencies();

    Bloc.observer = SimpleBlocObserver();

    runApp(const MyApp());
  } catch (error, stackTrace) {
    debugPrint('Fatal initialization error: $error\n$stackTrace');
    runApp(ErrorScreen(
      error: error.toString(),
      stackTrace: stackTrace.toString(),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        // This is the key to preventing fontSize: 0 crash
        ensureScreenSize: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: FlavorConfig.instance.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRouter.getRouter(
              isLoggedIn: () async {
                try {
                  final storage = di.getIt<LocalStorage>();
                  final (token, _) = await storage.get<String>('auth_token');
                  return token != null && token.isNotEmpty;
                } catch (_) {
                  return false;
                }
              },
            ),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.noScaling,
                ),
                child: widget!,
              );
            },
          );
        },
      ),
    );
  }
}
