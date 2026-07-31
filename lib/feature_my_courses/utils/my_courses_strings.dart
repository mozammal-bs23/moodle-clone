/// User-facing strings for the My Courses screen.
///
/// Copy lifted from the target screenshot (`assets/design/screens/...`)
/// and the eLearning23 reference mocks. Kept in one place so the page
/// and widgets stay focused on layout.
abstract class MyCoursesStrings {
  MyCoursesStrings._();

  // Site header.
  static const String siteName = 'eLearning23';
  static const String userInitials = 'SU';

  // Page title.
  static const String pageTitle = 'My courses';

  // Filter row.
  static const String filterHint = 'Filter my courses';
  static const String statusFilterInProgress = 'In progress';
  static const String sortTooltip = 'Sort';
  static const String layoutGridTooltip = 'Grid view';

  // Status filter dropdown options.
  static const String statusAll = 'All';
  static const String statusInProgress = 'In progress';
  static const String statusFuture = 'Future';
  static const String statusPast = 'Past';
  static const String statusFavourites = 'Favourites';
  static const String statusHidden = 'Hidden';

  // Sort options.
  static const String sortTitle = 'Sort by';
  static const String sortLastAccessed = 'Last accessed';
  static const String sortTitleAsc = 'Title';

  // Card overflow menu.
  static const String cardMenuTooltip = 'More options';
  static const String cardMenuDownload = 'Download course';
  static const String cardMenuFavourite = 'Star this course';
  static const String cardMenuRemove = 'Remove from view';

  // Card overflow menu snackbars (shown until the underlying API call
  // is wired up — kept honest so users know the action isn't a no-op).
  static const String cardActionDownloadPending =
      'Offline download is coming soon.';
  static const String cardActionRemovePending =
      'Remove-from-view will sync to Moodle when supported.';
  static const String cardActionFavouritePending =
      'Favourites sync to Moodle when supported.';

  // Bottom navigation.
  static const String navDashboard = 'Dashboard';
  static const String navCourses = 'Courses';
  static const String navMessages = 'Messages';
  static const String navNotifications = 'Notifications';
  static const String navMore = 'More';

  // Misc.
  static const String lockedBadge = 'Locked';
  static const String loading = 'Loading your courses…';
  static const String errorTitle = 'Something went wrong';
  static const String errorRetry = 'Try Again';
}