import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_auth/pages/login_page.dart';
import 'package:flutter_boilerplate/feature_post/pages/posts_page.dart';
import 'package:flutter_boilerplate/feature_set_base_url/pages/set_base_url_page.dart';
import 'package:flutter_boilerplate/feature_splash/pages/splash_page.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:flutter_boilerplate/routes/route_observer.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  /// Private constructor
  AppRouter._();

  /// Route observer instance for tracking navigation
  static final AppRouteObserver routeObserver = AppRouteObserver();

  /// Get the router configuration
  static GoRouter getRouter({
    required Future<bool> Function() isLoggedIn,
    String? redirectLocation,
  }) {
    return GoRouter(
      initialLocation: AppRoutes.splash,
      debugLogDiagnostics: true,
      observers: [routeObserver],
      errorBuilder: (context, state) =>
          _buildErrorPage(context, state.error, state.uri.toString()),
      routes: <RouteBase>[
        // Splash Route
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashPage(),
        ),

        // Auth Routes
        GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.login,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LoginPage()),
        ),

        // Posts Routes (JSONPlaceholder CRUD demo)
        GoRoute(
          path: AppRoutes.posts,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: PostsPage()),
        ),

        // Set Base URL Route (Connect to Moodle)
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SetBaseUrlPage()),
        ),
      ],
    );
  }

  /// Build error page for routing errors
  static Widget _buildErrorPage(
    BuildContext context,
    Exception? error,
    String location,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.labelError)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(AppStrings.errorNavigation),
            if (error != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('Back to Splash'),
            ),
          ],
        ),
      ),
    );
  }
}
