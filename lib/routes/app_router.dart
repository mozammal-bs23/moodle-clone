import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_course/pages/course_overview_screen.dart';
import 'package:flutter_boilerplate/feature_post/pages/posts_page.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:flutter_boilerplate/routes/route_observer.dart';
import 'package:go_router/go_router.dart';


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
      initialLocation: AppRoutes.courseOverview,
      debugLogDiagnostics: true,

      // Route observers for analytics and logging
      observers: [routeObserver],

      // Error handling
      errorBuilder: (context, state) =>
          _buildErrorPage(context, state.error, state.uri.toString()),

      routes: <GoRoute>[
        // Posts Routes (JSONPlaceholder CRUD demo)
        GoRoute(
          path: AppRoutes.posts,
          name: AppRoutes.posts,
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: PostsPage()),
        ),
        // Course Overview Route
        GoRoute(
          path: AppRoutes.courseOverview,
          name: AppRoutes.courseOverview,
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: CourseOverviewScreen()),
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
              onPressed: () => context.go(AppRoutes.posts),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
