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

/// String constants used throughout the app
class AppStrings {
  /// Error messages
  static const String errorGeneral = 'An unexpected error occurred';

  /// Network error message
  static const String errorNetwork =
      'Network error. Please check your connection';

  /// Timeout error message
  static const String errorTimeout = 'Request timed out';

  /// Server error message
  static const String errorServer = 'Server error. Please try again later';

  /// Authentication error message
  static const String errorUnauthorized = 'Unauthorized access';

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

  /// Cancel label
  static const String labelCancel = 'Cancel';

  /// OK label
  static const String labelOk = 'OK';

  /// Save label
  static const String labelSave = 'Save';

  /// Delete label
  static const String labelDelete = 'Delete';

  /// Edit label
  static const String labelEdit = 'Edit';

  /// Submit label
  static const String labelSubmit = 'Submit';

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

  /// Reconnect screen
  static const String lostPassword = 'Lost password?';

  /// Login
  static const String login = 'Log in';

  /// Password field
  static const String password = 'Password';

  /// Reconnect title
  static const String reconnect = 'Reconnect';

  /// Reconnect site name
  static const String siteName = 'eLearning23';

  /// Reconnect site URL
  static const String siteUrl = 'https://lmsmobile.ahnafmuttaki.com';

  /// OR label
  static const String or = 'Or';

  /// QR button label
  static const String scanQrCode = 'Scan QR code';

  /// User initials
  static const String userInitials = 'SU';

  /// User name
  static const String userName = 'Student User';
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

  /// Custom spacing (20)
  static const double mdLg = 20;

  /// Custom spacing (28)
  static const double lgMd = 28;

  /// Custom spacing (30)
  static const double lgXs = 30;

  /// Custom spacing (36)
  static const double xlSm = 36;
  static const double xxs = 1.5;

  /// Tiny spacing (0.2)
  static const double tiny = 0.2;

  /// Medium-small spacing (10)
  static const double mdSm = 10;
}

/// App size constants
class AppSize {
  const AppSize._();

  /// Small icon size (16)
  static const double iconSm = 16;

  /// Medium icon size (24)
  static const double iconMd = 24;

  /// Large icon size (32)
  static const double iconLg = 32;

  /// Extra large icon size (48)
  static const double iconXl = 48;

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

  /// Tiny border radius (2)
  static const double radiusXs = 2;

  /// Forgot password underline width (98)
  static const double forgotPasswordUnderlineWidth = 98;

  /// Divider thickness (1)
  static const double dividerThickness = 1;

  /// Body text size (16)
  static const double textMd = 16;

  /// Login button height (44)
  static const double buttonHeight = 44;

  /// Small text size (15)
  static const double textSm = 15;

  /// Small letter spacing (1)
  static const double letterSpacingSm = 1;

  /// No elevation
  static const double elevationNone = 0;

  /// Password field minimum suffix icon size (36)
  static const double suffixIconMinSize = 36;

  /// Icon splash radius (18)
  static const double iconSplashRadius = 18;

  /// Password underline width
  static const double passwordUnderlineWidth = 0.7;

  /// Password focused underline width
  static const double passwordFocusedUnderlineWidth = 1.1;

  /// Header height (48)
  static const double headerHeight = 48;

  /// Header icon button size (32)
  static const double headerIconButtonSize = 32;

  /// Header icon size (22)
  static const double headerIconSize = 22;

  /// Header title font size (20)
  static const double headerTitleSize = 20;

  /// Header title letter spacing (-0.2)
  static const double headerLetterSpacing = -0.2;

  /// Logo title font size (19)
  static const double logoTitleSize = 19;

  /// No letter spacing
  static const double letterSpacingNone = 0;

  /// Small text size (14)
  static const double textXs = 14;

  /// Standard border width (1)
  static const double borderWidth = 1;

  /// Avatar size (78)
  static const double avatarSize = 78;

  /// Avatar initials font size (24)
  static const double avatarInitialSize = 24;
}
