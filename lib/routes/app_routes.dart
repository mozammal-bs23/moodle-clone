/// Route name constants for the application
/// 
/// This class contains all route names used in the app
/// for navigation and route generation.
abstract class AppRoutes {
  /// Private constructor to prevent instantiation
  AppRoutes._();
  
  // Auth routes
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  
  // Home routes
  static const String home = '/home';
  static const String homeDetail = '/home/detail';
  
  // Settings routes
  static const String settings = '/settings';
  static const String profile = '/profile';
  
  // Error routes
  static const String notFound = '/not-found';
  static const String serverError = '/server-error';
}
