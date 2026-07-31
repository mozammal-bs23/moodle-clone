/// Route name constants for the application
///
/// This class contains all route names used in the app
/// for navigation and route generation.
abstract class AppRoutes {
  /// Private constructor to prevent instantiation
  AppRoutes._();

  // Auth routes
  /// Splash screen route
  static const String splash = '/';

  /// Authentication routes
  static const String login = '/login';

  /// Registration route
  static const String register = '/register';

  /// Forgot password route
  static const String forgotPassword = '/forgot-password';

  /// Posts route (JSONPlaceholder CRUD demo)
  static const String posts = '/posts';

  /// Settings routes
  static const String settings = '/settings';

  /// Profile route
  static const String profile = '/profile';

  /// Error routes
  static const String notFound = '/not-found';

  /// Server error route
  static const String serverError = '/server-error';

  // Set Base URL feature routes
  /// QR code scanner route
  static const String qrScanner = '/qr-scanner';

  /// App settings route
  static const String appSettings = '/app-settings';

  /// Help route
  static const String help = '/help';
}
