import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'app_routes.dart';
import 'route_observer.dart';
import '../feature_home/pages/home_page.dart';
import '../feature_home/pages/home_detail_page.dart';

/// GoRouter configuration for the application
///
/// Handles routing, navigation guards, deep linking, and error handling
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
      initialLocation: AppRoutes.home,
      debugLogDiagnostics: true,

      // Route observers for analytics and logging
      observers: [routeObserver],

      // Error handling
      errorBuilder: (context, state) => _buildErrorPage(
        context,
        state.error,
        state.uri.toString(),
      ),

      routes: <GoRoute>[
        // Home Routes
        GoRoute(
          path: AppRoutes.home,
          name: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
          routes: [
            GoRoute(
              path: 'detail/:id',
              name: AppRoutes.homeDetail,
              pageBuilder: (context, state) {
                final id = state.pathParameters['id']!;
                return MaterialPage(
                  key: state.pageKey,
                  child: HomeDetailPage(id: id),
                );
              },
            ),
          ],
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
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Navigation error occurred'),
            if (error != null) ...[
              const SizedBox(height: 16),
              Text(error.toString()),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
