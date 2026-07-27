import 'package:flutter/material.dart';

/// Application-wide constants
class AppConstants {
  /// App name
  static const String appName = 'Flutter Boilerplate';

  /// App version
  static const String appVersion = '1.0.0';

  /// Base URL for API endpoints
  static const String baseUrl = 'https://api.example.com';

  /// Connection timeout in seconds
  static const int connectionTimeout = 30;

  /// Receive timeout in seconds
  static const int receiveTimeout = 30;

  /// Shared preferences file name
  static const String prefsFileName = 'flutter_boilerplate_prefs';

  /// Cache directory name
  static const String cacheDir = 'cache';

  /// Default page size for pagination
  static const int defaultPageSize = 20;

  /// Maximum number of retries for network requests
  static const int maxRetries = 3;

  /// Auth token key in storage
  static const String tokenKey = 'auth_token';

  /// Refresh token key in storage
  static const String refreshTokenKey = 'refresh_token';

  /// User ID key in storage
  static const String userIdKey = 'user_id';
}

/// App brand colors
class AppBrandColors {
  const AppBrandColors._();

  /// Moodle brand colors
  static const Color moodleOrange = Color(0xFFF98012);
}

/// String constants used throughout the app
class AppStrings {
  /// Error messages
  static const String errorGeneral = 'An unexpected error occurred';
  static const String errorSomethingWentWrong = 'Oops! Something went wrong';
  static const String errorUnexpectedNotify =
      'An unexpected error occurred. Our team has been notified.';
  static const String errorDetails = 'Error Details:';
  static const String errorStackTrace = 'Stack Trace';

  /// Network error message
  static const String errorNetwork =
      'Network error. Please check your connection';

  /// Timeout error message
  static const String errorTimeout = 'Request timed out';

  /// Server error message
  static const String errorServer = 'Server error. Please try again later';

  /// Authentication error message
  static const String errorUnauthorized = 'Unauthorized access';

  /// Navigation error message
  static const String errorNavigation = 'Navigation error occurred';

  /// Validation error message
  static const String errorValidation = 'Please fix the errors in the form';

  /// Bad request error message
  static const String errorBadRequest = 'Invalid request';

  /// Success messages
  static const String successOperation = 'Operation completed successfully';

  /// Generic labels
  /// Loading label
  static const String labelLoading = 'Loading...';
  /// Error label
  static const String labelError = 'Error';
  /// Retry label
  static const String labelRetry = 'Retry';
  /// Try Again label
  static const String labelTryAgain = 'Try Again';
  /// Cancel label
  static const String labelCancel = 'Cancel';
  /// OK label
  static const String labelOk = 'OK';
  /// Post labels
  static const String labelPosts = 'Posts';
  static const String labelPostsDemo = 'Posts (JSONPlaceholder demo)';
  static const String labelCreatePost = 'Create post';
  static const String labelEditPost = 'Edit post (PUT)';
  static const String labelPatchTitle = 'Quick patch title (PATCH)';
  static const String labelTitle = 'Title';
  static const String labelBody = 'Body';
  static const String labelCreate = 'Create';
  static const String labelPatch = 'Patch';
  static const String emptyNoPosts = 'No posts';
  static const String bannerDemo =
      'Demo API: creates/edits/deletes are accepted by the server but '
      'never actually persist. The list resets to the original 100 '
      'posts on every refresh.';

  /// Save label
  static const String labelSave = 'Save';
  /// Delete label
  static const String labelDelete = 'Delete';
  /// Edit label
  static const String labelEdit = 'Edit';
  /// Submit label
  static const String labelSubmit = 'Submit';
  /// Go Home label
  static const String labelGoHome = 'Go Home';

  /// Empty states
  /// No data message
  static const String emptyNoData = 'No data available';
  /// No search results message
  static const String emptySearch = 'No results found';
  /// No favorites message
  static const String emptyFavorites = 'No favorites yet';

  /// Connectivity
  /// Connectivity status label
  static const String connectivityStatus = 'Connectivity status';
  /// Online status label
  static const String connectivityOnline = 'Online';
  /// Offline status label
  static const String connectivityOffline = 'Offline';
}

/// Spacing constants for consistent padding/margins
///
/// Values are defined in logical pixels and can be used with
/// EdgeInsets.all(), EdgeInsets.symmetric(), etc.
/// For responsive sizing with ScreenUtil, use .w, .h, .r extensions
class AppSpacing {
  const AppSpacing._();

  /// Extra small spacing (4)
  static const double xs = 4;

  /// Small spacing (8)
  static const double sm = 8;

  /// Medium spacing (16)
  static const double md = 16;

  /// Large spacing (24)
  static const double lg = 24;

  /// Extra large spacing (32)
  static const double xl = 32;

  /// Extra extra large spacing (48)
  static const double xxl = 48;
}

/// App size constants
class AppSize {
  const AppSize._();

  /// Design size for ScreenUtil
  static const double designWidth = 375;
  static const double designHeight = 812;

  /// Small icon size (16)
  static const double iconSm = 16;

  /// Medium icon size (24)
  static const double iconMd = 24;

  /// Large icon size (32)
  static const double iconLg = 32;

  /// Extra large icon size (48)
  static const double iconXl = 48;

  /// Extra extra large icon size (64)
  static const double iconXXl = 64;

  /// Splash logo width
  static const double splashLogoWidth = 200;

  /// Splash logo error size
  static const double splashLogoErrorSize = 100;

  /// Small border radius (4)
  static const double radiusSm = 4;

  /// Medium border radius (8)
  static const double radiusMd = 8;

  /// Large border radius (12)
  static const double radiusLg = 12;

  /// Extra large border radius (16)
  static const double radiusXl = 16;

  /// Full border radius (9999)
  static const double radiusFull = 9999;

  /// Small elevation (2)
  static const double elevationSm = 2;

  /// Medium elevation (4)
  static const double elevationMd = 4;

  /// Large elevation (8)
  static const double elevationLg = 8;
}
