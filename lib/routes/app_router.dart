import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import 'route_observer.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/home/presentation/pages/home_detail_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../core.dart' show AppFailure;


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
      initialLocation: AppRoutes.splash,
      debugLogDiagnostics: true,
      
      // Route observers for analytics and logging
      observers: [routeObserver],
      
      // Error handling
      errorBuilder: (context, state) => _buildErrorPage(
        context,
        state.error,
        state.uri.toString(),
      ),
      
      // Redirect logic for authentication
      redirect: (BuildContext context, GoRouterState state) async {
        // Check authentication status
        final loggedIn = await isLoggedIn();
        final isAuthRoute = _isAuthRoute(state.matchedLocation);
        final isSplashRoute = state.matchedLocation == AppRoutes.splash;
        
        // If not logged in and trying to access protected route, redirect to login
        if (!loggedIn && !isAuthRoute && !isSplashRoute) {
          return AppRoutes.login;
        }
        
        // If logged in and on auth route, redirect to home
        if (loggedIn && isAuthRoute) {
          return AppRoutes.home;
        }
        
        // If on splash and logged in, redirect to home
        if (isSplashRoute && loggedIn) {
          return AppRoutes.home;
        }
        
        // No redirect needed
        return null;
      },
      
      routes: <GoRoute>[
        // Splash / Initial Route
        GoRoute(
          path: AppRoutes.splash,
          name: AppRoutes.splash,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SplashPage(),
          ),
        ),
        
        // Auth Routes
        GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.login,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const LoginPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.register,
          name: AppRoutes.register,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const RegisterPage(),
          ),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword,
          name: AppRoutes.forgotPassword,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ForgotPasswordPage(),
          ),
        ),
        
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
        
        // Settings Route
        GoRoute(
          path: AppRoutes.settings,
          name: AppRoutes.settings,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SettingsPage(),
          ),
        ),
        
        // Profile Route
        GoRoute(
          path: AppRoutes.profile,
          name: AppRoutes.profile,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const ProfilePage(),
          ),
        ),
      ],
      
      // Custom 404 page for unmatched routes
      unknownRoute: GoRoute(
        path: AppRoutes.notFound,
        name: AppRoutes.notFound,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: NotFoundPage(uri: state.uri),
        ),
      ),
    );
  }
  
  /// Check if a route is an authentication route
  static bool _isAuthRoute(String? path) {
    if (path == null) return false;
    return path == AppRoutes.login || 
           path == AppRoutes.register || 
           path == AppRoutes.forgotPassword;
  }
  
  /// Build error page with appropriate message
  static Widget _buildErrorPage(
    BuildContext context,
    Object? error,
    String location,
  ) {
    String message = 'An unexpected error occurred';
    String? details;
    
    if (error is AppFailure) {
      message = error.message;
      details = error.details;
    } else if (error != null) {
      message = error.toString();
    }
    
    return ErrorPage(
      message: message,
      details: details,
      location: location,
    );
  }
}

/// Splash page shown during app initialization
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Initialize app and redirect based on auth state
    _initializeApp();
  }
  
  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    
    // Check auth state and navigate
    final isLoggedIn = false; // TODO: Get from auth repository
    if (isLoggedIn) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.login);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            const SizedBox(height: 24),
            const Text(
              'Flutter Boilerplate',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

/// Error page for displaying errors
class ErrorPage extends StatelessWidget {
  final String message;
  final String? details;
  final String location;
  
  const ErrorPage({
    super.key,
    required this.message,
    this.details,
    required this.location,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 64,
              ),
              const SizedBox(height: 24),
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (details != null) ...[
                const SizedBox(height: 8),
                Text(
                  details!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 16),
              Text(
                'Location: $location',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.home),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 404 Not Found page
class NotFoundPage extends StatelessWidget {
  final Uri uri;
  
  const NotFoundPage({super.key, required this.uri});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 24),
              Text(
                '404 - Page Not Found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'The page "$uri" could not be found.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.home),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
