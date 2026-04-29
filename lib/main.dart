import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/lib/flutter_boilerplate_core.dart';
import 'src/injection/di.dart' as di;
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set bloc observer for debugging
  Bloc.observer = SimpleBlocObserver();
  
  // Initialize dependency injection
  // This also initializes Hive and pre-resolves SharedPreferences
  await di.configureDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Flutter Boilerplate',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: AppRouter.getRouter(
            isLoggedIn: () async {
              // Check authentication state
              final (token, _) = await di.getIt<LocalStorage>().get<String>('auth_token');
              return token != null && token.isNotEmpty;
            },
          ),
          builder: (context, child) {
            // Override ScreenUtil context
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.noScaling,
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
