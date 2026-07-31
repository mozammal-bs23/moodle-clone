import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_app_settings/pages/app_settings_page.dart';
import 'package:flutter_boilerplate/feature_more/pages/more_page.dart';
import 'package:flutter_boilerplate/feature_post/pages/posts_page.dart';
import 'package:flutter_boilerplate/feature_set_base_url/pages/set_base_url_page.dart';
import 'package:flutter_boilerplate/feature_webview_about/pages/about_page.dart';
import 'package:flutter_boilerplate/feature_webview_about/pages/web_view_page.dart';
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
      initialLocation: AppRoutes.more,
      debugLogDiagnostics: true,

      // Route observers for analytics and logging
      observers: [routeObserver],

      // Error handling
      errorBuilder: (context, state) =>
          _buildErrorPage(context, state.error, state.uri.toString()),

      routes: <GoRoute>[
        // More Routes
        GoRoute(
          path: AppRoutes.more,
          name: AppRoutes.more,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MorePage()),
        ),

        // Posts Routes (JSONPlaceholder CRUD demo)
        GoRoute(
          path: AppRoutes.posts,
          name: AppRoutes.posts,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: PostsPage()),
        ),

        // Set base URL screen (added on main)
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SetBaseUrlPage()),
        ),

        // App Settings Route
        GoRoute(
          path: AppRoutes.appSettings,
          name: AppRoutes.appSettings,
          builder: (context, state) => const AppSettingsPage(),
        ),

        // About Route
        GoRoute(
          path: AppRoutes.about,
          name: AppRoutes.about,
          builder: (context, state) => const AboutPage(),
        ),

        // WebView Route — receives a `url` argument via state.extra.
        GoRoute(
          path: AppRoutes.webview,
          name: AppRoutes.webview,
          builder: (context, state) {
            final url = state.extra as String?;
            if (url == null || url.isEmpty) {
              return const _MissingWebViewUrlPage();
            }
            return WebViewPage(url: url);
          },
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

/// Fallback page shown when [WebViewPage] is pushed without a URL.
class _MissingWebViewUrlPage extends StatelessWidget {
  /// Creates an instance of [_MissingWebViewUrlPage].
  const _MissingWebViewUrlPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop<void>(),
        ),
      ),
      body: const Center(
        child: Text('No URL provided for the WebView.'),
      ),
    );
  }
}
