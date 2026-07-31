import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_set_base_url/pages/app_settings_page.dart';
import 'package:flutter_boilerplate/feature_set_base_url/pages/help_page.dart';
import 'package:flutter_boilerplate/feature_set_base_url/pages/qr_scanner_page.dart';
import 'package:flutter_boilerplate/feature_set_base_url/pages/set_base_url_page.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:flutter_boilerplate/routes/route_observer.dart';
import 'package:go_router/go_router.dart';

/// Top-level router configuration. Mirrors the official Moodle app's
/// entry points reachable from the Set Base URL page.
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

      // Route observers for analytics and logging
      observers: [routeObserver],

      // Error handling
      errorBuilder: (context, state) =>
          _buildErrorPage(context, state.error, state.uri.toString()),

      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.splash,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SetBaseUrlPage()),
        ),
        GoRoute(
          path: AppRoutes.qrScanner,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: QrScannerPage()),
        ),
        GoRoute(
          path: AppRoutes.appSettings,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: AppSettingsPage()),
        ),
        GoRoute(
          path: AppRoutes.help,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HelpPage()),
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
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}