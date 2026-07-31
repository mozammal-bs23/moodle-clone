import 'package:equatable/equatable.dart';

/// Status filter for the "In progress ▾" dropdown. Matches the values
/// exposed by the Moodle Web Services' `core_course_get_enrolled_courses`
/// bystatus param.
enum MyCoursesStatusFilter {
  all,
  inProgress,
  future,
  past,
  starred,
  removed;

  String get label => switch (this) {
        MyCoursesStatusFilter.all => 'All',
        MyCoursesStatusFilter.inProgress => 'In progress',
        MyCoursesStatusFilter.future => 'Future',
        MyCoursesStatusFilter.past => 'Past',
        MyCoursesStatusFilter.starred => 'Starred',
        MyCoursesStatusFilter.removed => 'Removed from view',
      };
}

/// Sort order for the sort icon in the filter row.
enum MyCoursesSortOrder { lastAccessed, titleAsc }

/// Card-list vs card-grid view toggle.
enum MyCoursesViewMode { list, grid }

/// UI-only course model. Mirrors what the design mock surfaces:
/// title, category, avatar tint seed, and a locked flag.
class MyCourseItem extends Equatable {
  const MyCourseItem({
    required this.id,
    required this.title,
    required this.category,
    this.categoryId = 0,
    this.categoryName = '',
    this.colorSeed = 0xFFB7A8FF,
    this.isLocked = false,
    this.progress,
    this.shortname = '',
    this.overviewUrl,
    this.startDate,
    this.endDate,
    this.visible = true,
  });

  /// Course id (parsed to `String` so it matches the existing widget
  /// code; we still keep `int` available by calling `int.tryParse(id)`).
  final String id;
  final String title;

  /// Pill text the UI displays. Always populated: when the API
  /// supplied a category name we use it verbatim, otherwise we fall
  /// back to the short name (or "Course" if that's empty too).
  final String category;

  /// Moodle category id — kept for the join lookup so widgets that
  /// want to render their own fallback can do so without round-tripping
  /// the state.
  final int categoryId;

  /// Category name from `core_course_get_categories` if the call
  /// succeeded, empty string otherwise. [category] prefers this when
  /// non-empty.
  final String categoryName;

  final int colorSeed;
  final bool isLocked;

  /// 0–100 progress percentage (null if API doesn't supply one).
  final double? progress;

  /// Short course code (e.g. "CS101"); currently unused but kept for
  /// future detail-page wiring.
  final String shortname;

  /// URL of the course overview image (null when not provided).
  final String? overviewUrl;

  /// Course start date (UTC ms since epoch) — used for the Future/Past
  /// status filters when the API provides them.
  final DateTime? startDate;

  /// Course end date (UTC ms since epoch).
  final DateTime? endDate;

  /// Whether the course is visible in Moodle. Used for the
  /// "Removed from view" / "Past" status filters.
  final bool visible;

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        categoryId,
        categoryName,
        colorSeed,
        isLocked,
        progress,
        shortname,
        overviewUrl,
        startDate,
        endDate,
        visible,
      ];
}

class MyCoursesState extends Equatable {
  const MyCoursesState({
    this.isLoading = false,
    this.errorMessage,
    this.courses = const <MyCourseItem>[],
    this.statusFilter = MyCoursesStatusFilter.all,
    this.sortOrder = MyCoursesSortOrder.lastAccessed,
    this.viewMode = MyCoursesViewMode.list,
    this.searchQuery = '',
  });

  final bool isLoading;
  final String? errorMessage;
  final List<MyCourseItem> courses;
  final MyCoursesStatusFilter statusFilter;
  final MyCoursesSortOrder sortOrder;
  final MyCoursesViewMode viewMode;
  final String searchQuery;

  /// Courses after all client-side filtering and sorting.
  List<MyCourseItem> get visibleCourses {
    Iterable<MyCourseItem> result = courses;

    // Search filter (free-text on title/category, case-insensitive).
    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      result = result.where(
        (c) =>
            c.title.toLowerCase().contains(q) ||
            c.category.toLowerCase().contains(q),
      );
    }

    // Status filter — uses the date fields the Moodle API provides.
    // "Now" is captured per evaluation so the filter is stable for the
    // current frame even if the wall clock ticks mid-build.
    if (statusFilter != MyCoursesStatusFilter.all) {
      final now = DateTime.now();
      result = result.where((c) {
        switch (statusFilter) {
          case MyCoursesStatusFilter.all:
            return true;
          case MyCoursesStatusFilter.inProgress:
            // Currently active: started (or no start) and not yet ended.
            final hasStarted =
                c.startDate == null || !c.startDate!.isAfter(now);
            final hasEnded = c.endDate != null && c.endDate!.isBefore(now);
            return hasStarted && !hasEnded && c.visible;
          case MyCoursesStatusFilter.future:
            return c.startDate != null && c.startDate!.isAfter(now);
          case MyCoursesStatusFilter.past:
            return c.endDate != null && c.endDate!.isBefore(now);
          case MyCoursesStatusFilter.starred:
            // No starred flag from the API yet — fall back to "all".
            // Wired up here so the dropdown isn't dead once the field
            // is added to the model.
            return true;
          case MyCoursesStatusFilter.removed:
            return !c.visible;
        }
      });
    }

    final list = result.toList();
    switch (sortOrder) {
      case MyCoursesSortOrder.titleAsc:
        list.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
      case MyCoursesSortOrder.lastAccessed:
        // Placeholder: keep insertion order. The API should provide a
        // "last accessed" timestamp we can switch to later.
        break;
    }
    return list;
  }

  MyCoursesState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    List<MyCourseItem>? courses,
    MyCoursesStatusFilter? statusFilter,
    MyCoursesSortOrder? sortOrder,
    MyCoursesViewMode? viewMode,
    String? searchQuery,
  }) {
    return MyCoursesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      courses: courses ?? this.courses,
      statusFilter: statusFilter ?? this.statusFilter,
      sortOrder: sortOrder ?? this.sortOrder,
      viewMode: viewMode ?? this.viewMode,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        courses,
        statusFilter,
        sortOrder,
        viewMode,
        searchQuery,
      ];
}