import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/dashboard_page.dart';
import 'package:flutter_boilerplate/feature_post/pages/posts_page.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:flutter_boilerplate/routes/route_observer.dart';
import 'package:go_router/go_router.dart';

/// GoRouter configuration for the application
class AppRouter {
  AppRouter._();

  static final AppRouteObserver routeObserver = AppRouteObserver();
  
  static GoRouter? _router;

  /// Get the router configuration
  static GoRouter getRouter({
    required Future<bool> Function() isLoggedIn,
  }) {
    _router ??= GoRouter(
      initialLocation: AppRoutes.dashboard,
      debugLogDiagnostics: true,
      observers: [routeObserver],
      errorBuilder: (context, state) => Scaffold(
        body: Center(child: Text('Page not found: ${state.uri}')),
      ),
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          redirect: (_, __) => AppRoutes.dashboard,
        ),
        GoRoute(
          path: AppRoutes.posts,
          name: AppRoutes.posts,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: PostsPage()),
        ),
        GoRoute(
          path: AppRoutes.dashboard,
          name: AppRoutes.dashboard,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: DashboardPage()),
        ),
      ],
    );
    return _router!;
  }
}
