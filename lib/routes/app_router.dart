import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_my_courses/cubit/my_courses_state.dart';
import 'package:flutter_boilerplate/feature_my_courses/pages/my_course_detail_page.dart';
import 'package:flutter_boilerplate/feature_my_courses/pages/my_courses_page.dart';
import 'package:flutter_boilerplate/feature_qr_scan/pages/qr_scan_page.dart';
import 'package:flutter_boilerplate/feature_set_base_url/pages/set_base_url_page.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:flutter_boilerplate/routes/route_observer.dart';
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
      initialLocation: AppRoutes.myCourses,
      debugLogDiagnostics: true,

      // Route observers for analytics and logging
      observers: [routeObserver],

      // Error handling
      errorBuilder: (context, state) =>
          _buildErrorPage(context, state.error, state.uri.toString()),

      routes: <GoRoute>[
        // My Courses is the post-login landing screen.
        GoRoute(
          path: AppRoutes.myCourses,
          pageBuilder: (context, state) => const MaterialPage(
            child: MyCoursesPage(),
          ),
        ),
        // Course detail page receives the MyCourseItem via state.extra
        // so we don't have to fetch it again. Falls back to a sane empty
        // page if the extra is missing (deep link).
        GoRoute(
          path: AppRoutes.courseDetail,
          pageBuilder: (context, state) {
            final extra = state.extra;
            final course = extra is MyCourseItem ? extra : null;
            return MaterialPage(
              child: MyCourseDetailPage(course: course),
            );
          },
        ),
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SetBaseUrlPage()),
        ),
        GoRoute(
          path: AppRoutes.qrScan,
          pageBuilder: (context, state) => const MaterialPage(
            fullscreenDialog: true,
            child: QrScanPage(),
          ),
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
