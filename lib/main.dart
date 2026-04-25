import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/injection/di.dart' as di;
import 'src/storage/local_storage.dart';
import 'routes/app_router.dart';
import 'src/theme/app_theme.dart';
import 'src/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set bloc observer for debugging
  Bloc.observer = SimpleBlocObserver();
  
  // Initialize dependency injection
  await di.configureDependencies();
  
  // Initialize local storage
  await di.getIt<LocalStorage>().init();
  
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
              final result = await di.getIt<LocalStorage>().get<String>('auth_token');
              return result.when(
                success: (token) => token != null && token.isNotEmpty,
                failure: (_) => false,
              );
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