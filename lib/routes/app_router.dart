import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature_dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/available_courses_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/badges_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/blog_entries_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/calendar_page.dart';
import 'package:flutter_boilerplate/feature_dashboard/pages/calendar_settings_page.dart';
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
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
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
          path: AppRoutes.calendar,
          name: AppRoutes.calendar,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CalendarPage()),
        ),
        GoRoute(
          path: AppRoutes.calendarSettings,
          name: AppRoutes.calendarSettings,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: CalendarSettingsPage()),
        ),
        GoRoute(
          path: AppRoutes.calendarReminderSettings,
          name: AppRoutes.calendarReminderSettings,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ReminderSettingsPage()),
        ),
        GoRoute(
          path: AppRoutes.availableCourses,
          name: AppRoutes.availableCourses,
          builder: (context, state) => BlocProvider(
            create: (_) => di.getIt<DashboardCubit>(),
            child: const AvailableCoursesPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.myCourses,
          name: AppRoutes.myCourses,
          builder: (context, state) => BlocProvider(
            create: (_) => di.getIt<DashboardCubit>(),
            child: const MyCoursesPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.messages,
          name: AppRoutes.messages,
          builder: (context, state) => BlocProvider(
            create: (_) => di.getIt<DashboardCubit>(),
            child: const MessagesPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.notifications,
          name: AppRoutes.notifications,
          builder: (context, state) => BlocProvider(
            create: (_) => di.getIt<DashboardCubit>(),
            child: const NotificationsPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.more,
          name: AppRoutes.more,
          builder: (context, state) => BlocProvider(
            create: (_) => di.getIt<DashboardCubit>(),
            child: const MorePage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.userDetails,
          name: AppRoutes.userDetails,
          builder: (context, state) => const UserDetailsPage(),
        ),
        GoRoute(
          path: AppRoutes.details,
          name: AppRoutes.details,
          builder: (context, state) {
            final courseId = state.uri.queryParameters['courseId'];
            return DetailsPage(courseId: courseId);
          },
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
