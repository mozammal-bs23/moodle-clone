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

  /// Connect to Moodle screen
  static const String connectToMoodle = 'Connect to Moodle';
  static const String yourSite = 'Your site';
  static const String siteHint = 'https://campus.example.edu';
  static const String needHelp = 'Need help?';
  static const String scanQrCode = 'Scan QR code';
  static const String or = 'OR';
  static const String pleaseSelectYourAccount = 'Please select your account:';
  static const String connectToYourSite = 'Connect to your site';

  /// Site suggestion search
  static const String suggestionSectionTitle = 'Suggested site';
  static const String suggestionLoadingLabel = 'Looking up site...';
  static const String suggestionEmptyLabel = 'No matching site found';
  static const String suggestionEmptyHint =
      'Type the address of your Moodle site to see suggestions.';
  static const String suggestionErrorLabel =
      'Couldn\u2019t reach this site. Check the URL or your connection.';
  static const String suggestionRetryLabel = 'Retry';
  static const String suggestionAuthenticatedBadge = 'Signed in';
  static const String suggestionGuestBadge = 'Guest';
  static const String suggestionSignedInAs = 'Signed in as';
  static const String suggestionGuestSession = 'Guest session';
  static const String suggestionSiteLabel = 'Site';
  static const String suggestionVersionLabel = 'Version';
  static const String suggestionVersionUnavailable = '\u2014';

  /// Site verification card regions.
  static const String verificationSiteRegion = 'Site';
  static const String verificationSessionRegion = 'Session';
  static const String verificationCapabilitiesRegion = 'Capabilities';
  static const String verificationStorageRegion = 'Storage';
  static const String verificationServerRegion = 'Server';
  static const String verificationWebServicesRegion = 'Web Services';
  static const String verificationRegionBadge = 'Admin';
  static const String verificationRegionPolicyRequired =
      'Policy agreement required';
  static const String verificationRegionPolicyAgreed = 'Policy agreed';
  static const String verificationRegionLanguage = 'Language';
  static const String verificationRegionSiteId = 'Site ID';
  static const String verificationRegionCalendar = 'Calendar';
  static const String verificationRegionConcurrentLogins =
      'Concurrent logins';
  static const String verificationRegionConcurrentLoginsUnlimited =
      'Unlimited';
  static const String verificationRegionBuild = 'Build';
  static const String verificationRegionWebServiceSummary =
      'web service functions enabled';
  static const String verificationRegionViewFunctions = 'View functions';
  static const String verificationRegionQuota = 'Quota';
  static const String verificationRegionMaxFileSize = 'Max upload size';
  static const String verificationRegionDownloads = 'Downloads';
  static const String verificationRegionUploads = 'Uploads';
  static const String verificationRegionDownloadsAllowed = 'Allowed';
  static const String verificationRegionDownloadsBlocked = 'Blocked';
  static const String verificationRegionTheme = 'Theme';

  /// Feature chip labels (for `advancedfeatures[]`).
  static const String featureMessaging = 'Messaging';
  static const String featureCompletion = 'Completion tracking';
  static const String featureBadges = 'Badges';
  static const String featureNotes = 'Notes';
  static const String featureBlogs = 'Blogs';
  static const String featureTags = 'Tags';
  static const String featureComments = 'Comments';
  static const String featureCustomReports = 'Custom reports';
  static const String featureCompetencies = 'Competencies';
  static const String featureGlobalSearch = 'Global search';
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

/// Duration constants for timeouts, debounce, and animations.
class AppDuration {
  /// Private constructor — use the static members instead.
  const AppDuration._();

  /// Debounce window for the Base URL search input.
  ///
  /// Wider than the original 500 ms because
  /// `core_webservice_get_site_info` does not accept a query parameter —
  /// it always returns the same single site regardless of what the user
  /// typed. Firing on every keystroke therefore wastes a network round
  /// trip per character. The cubit treats a long idle (this value) the
  /// same as an explicit commit (focus loss / "done" key).
  static const Duration searchDebounce = Duration(milliseconds: 1500);

  /// Animation duration for suggestion list cross-fades.
  static const Duration suggestionFade = Duration(milliseconds: 200);

  /// Default loading indicator delay before showing.
  static const Duration loadingIndicatorShow = Duration(milliseconds: 250);
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
  static const double smallIconButtonSize = 40;
  static const double qrButtonFontSize = 13;
  static const double qrButtonLetterSpacing = 1;
  static const double qrButtonRadius = 3;
  static const double borderWidthNone = 0;
  static const double horizontalPaddingNone = 0;

  /// Site suggestion widget sizes
  static const double suggestionIconSize = 22;
  static const double suggestionBadgeFontSize = 11;
  static const double suggestionTileVerticalPadding = 12;
  static const double suggestionBadgePadding = 6;
  static const double suggestionMinHeight = 56;
  static const double suggestionLabelWidth = 56;
  static const double suggestionAvatarSize = 32;
  static const double suggestionIdentityLabelMaxWidth = 96;

  /// Site verification card sizes.
  static const double verificationCardVerticalPadding = 12;
  static const double verificationRegionHeaderHeight = 28;
  static const double verificationRegionHeaderFontSize = 13;
  static const double verificationRegionGap = 4;
  static const double verificationRegionInset = 12;
  static const double verificationAvatarSize = 56;
  static const double verificationChipFontSize = 11;
  static const double verificationChipHorizontalPadding = 8;
  static const double verificationChipVerticalPadding = 4;
  static const double verificationChipGap = 6;
  static const double verificationValueFontSize = 14;
  static const double verificationKeyFontSize = 12;
  static const double verificationKeyColumnWidth = 110;
  static const double verificationBottomSheetMaxHeight = 480;
  static const double verificationIconSm = 14;
  static const double verificationIconMd = 16;
  static const double verificationIconLg = 20;
}
