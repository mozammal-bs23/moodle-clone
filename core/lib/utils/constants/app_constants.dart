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

  /// Auth labels
  /// Login label
  static const String labelLogin = 'Log in';
  /// Username label
  static const String labelUsername = 'Username';
  /// Password label
  static const String labelPassword = 'Password';
  /// Lost password label
  static const String labelLostPassword = 'Lost Password?';
  /// Site name label
  static const String labelSiteName = 'eLearning23';
  /// Site URL label
  static const String labelSiteUrl = 'https://lmsmobile.ahnafmuttaki.com';

  /// More page labels
  /// More label
  static const String labelMore = 'More';
  /// Calendar label
  static const String labelCalendar = 'Calendar';
  /// Site blog label
  static const String labelSiteBlog = 'Site blog';
  /// Tags label
  static const String labelTags = 'Tags';
  /// Scan QR code label
  static const String labelScanQrCode = 'Scan QR code';
  /// App settings label
  static const String labelAppSettings = 'App settings';
  /// General label
  static const String labelGeneral = 'General';
  /// Space usage label
  static const String labelSpaceUsage = 'Space usage';
  /// Synchronisation label
  static const String labelSynchronisation = 'Synchronisation';
  /// About label
  static const String labelAbout = 'About';

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

  /// Connect to Moodle screen
  static const String connectToMoodle = 'Connect to Moodle';
  static const String yourSite = 'Your site';
  static const String siteHint = 'https://campus.example.edu';
  static const String needHelp = 'Need help?';
  static const String scanQrCode = 'Scan QR code';
  static const String or = 'OR';
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

  /// Custom spacing
  static const double xxs = 5;
  static const double mdSm = 10;
  static const double mdLg = 12;
  static const double xlSm = 22;
  static const double xlMd = 34;
  static const double xxlSm = 44;
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

  /// Font sizes
  static const double fontXs = 12;
  static const double fontSm = 14;
  static const double fontMd = 16;
  static const double fontLg = 20;

  /// Layout sizes
  static const double headerHeight = 40;
  static const double logoHeight = 80;
  static const double logoWidth = 550;

  /// Common values
  static const double lineHeight = 1;
  static const double dividerThickness = .8;
  static const double letterSpacingNone = 0;
  static const double letterSpacingTight = -.2;
  static const double splashRadius = 18;
  static const double iconSettings = 25;
  static const double iconButtonMinSize = 32;
  static const double helpBorderRadius = 5;
  static const double helpVerticalPadding = 2;

  static const double helpFontSize = 15;

  static const double helpDividerWidth = 72;
  static const double helpDividerHeight = .5;
  static const double helpDividerThickness = .5;
  static const double qrButtonHeight = 42;
  static const double qrIconSize = 22;
  static const double qrButtonFontSize = 13;
  static const double qrButtonLetterSpacing = 1;
  static const double qrButtonRadius = 3;
  static const double borderWidthNone = 0;
  static const double horizontalPaddingNone = 0;
}
