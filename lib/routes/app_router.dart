import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/available_courses_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/badges_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/blog_entries_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/dashboard_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/details_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/messages_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/more_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/my_courses_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/notifications_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/user_details_page.dart';
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
        GoRoute(
          path: AppRoutes.availableCourses,
          name: AppRoutes.availableCourses,
          builder: (context, state) => const AvailableCoursesPage(),
        ),
        GoRoute(
          path: AppRoutes.myCourses,
          name: AppRoutes.myCourses,
          builder: (context, state) => const MyCoursesPage(),
        ),
        GoRoute(
          path: AppRoutes.messages,
          name: AppRoutes.messages,
          builder: (context, state) => const MessagesPage(),
        ),
        GoRoute(
          path: AppRoutes.notifications,
          name: AppRoutes.notifications,
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          path: AppRoutes.more,
          name: AppRoutes.more,
          builder: (context, state) => const MorePage(),
        ),
        GoRoute(
          path: AppRoutes.userDetails,
          name: AppRoutes.userDetails,
          builder: (context, state) => const UserDetailsPage(),
        ),
        GoRoute(
          path: AppRoutes.details,
          name: AppRoutes.details,
          builder: (context, state) => const DetailsPage(),
        ),
        GoRoute(
          path: AppRoutes.badges,
          name: AppRoutes.badges,
          builder: (context, state) => const BadgesPage(),
        ),
        GoRoute(
          path: AppRoutes.blogEntries,
          name: AppRoutes.blogEntries,
          builder: (context, state) => const BlogEntriesPage(),
        ),
      ],
    );
    return _router!;
  }
}
