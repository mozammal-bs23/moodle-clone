import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_boilerplate/feature_my_courses/cubit/my_courses_state.dart';

/// Cubit for the My Courses page.
///
/// Owns all UI state (loading, error, list, status filter, sort order,
/// view mode, search query) so widgets stay pure. Only [fetchCourses]
/// and [refreshCourses] hit the API; everything else is a synchronous
/// state mutation.
class MyCoursesCubit extends Cubit<MyCoursesState> {
  /// Creates a [MyCoursesCubit] backed by the courses + categories use
  /// cases.
  MyCoursesCubit({
    required GetMyCoursesUseCase getMyCoursesUseCase,
    required GetCourseCategoriesUseCase getCourseCategoriesUseCase,
  })  : _getMyCoursesUseCase = getMyCoursesUseCase,
        _getCourseCategoriesUseCase = getCourseCategoriesUseCase,
        super(const MyCoursesState());

  final GetMyCoursesUseCase _getMyCoursesUseCase;
  final GetCourseCategoriesUseCase _getCourseCategoriesUseCase;

  /// Map a stable, deterministic colour to each course id so avatars
  /// stay consistent across rebuilds (no `Random()` calls per frame).
  static int _colorSeedForId(String id) {
    var hash = 0;
    for (final code in id.codeUnits) {
      hash = (hash * 31 + code) & 0x7fffffff;
    }
    // Keep it in the pastel range rather than the full ARGB space.
    final hue = hash % 360;
    final h = hue.toDouble();
    final s = 0.45;
    final l = 0.70;
    final c = (1 - (2 * l - 1).abs()) * (s);
    final x = c * (1 - ((h / 60) % 2 - 1).abs());
    final m = l - c / 2;
    double r = 0, g = 0, b = 0;
    if (h < 60) {
      r = c;
      g = x;
    } else if (h < 120) {
      r = x;
      g = c;
    } else if (h < 180) {
      g = c;
      b = x;
    } else if (h < 240) {
      g = x;
      b = c;
    } else if (h < 300) {
      r = x;
      b = c;
    } else {
      r = c;
      b = x;
    }
    final rr = ((r + m) * 255).round() & 0xff;
    final gg = ((g + m) * 255).round() & 0xff;
    final bb = ((b + m) * 255).round() & 0xff;
    return (0xff000000 | (rr << 16) | (gg << 8) | bb);
  }

  /// Fetch the courses (sets loading state, replaces list on success).
  ///
  /// Spec-named public entry point — equivalent to a previous `load()`.
  Future<void> fetchCourses() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    await _fetch();
  }

  /// Re-fetch the courses without flipping the loading indicator (used
  /// by the pull-to-refresh gesture in the body scroll view).
  ///
  /// Spec-named public entry point — equivalent to a previous `refresh()`.
  Future<void> refreshCourses() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    await _fetch();
  }

  Future<void> _fetch() async {
    try {
      // The categories lookup is best-effort: if it fails we still
      // render the course list with the shortname as the pill label.
      // Await the two calls sequentially so we can keep the record
      // (data, failure) destructure pattern consistent.
      final (courseData, courseFailure) = await _getMyCoursesUseCase();
      if (courseFailure != null) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: courseFailure.message,
        ));
        return;
      }

      final Map<int, String> nameByCategoryId = {};
      final (catData, catFailure) =
          await _getCourseCategoriesUseCase();
      if (catFailure == null && catData != null) {
        for (final c in catData) {
          if (c.name.isNotEmpty) nameByCategoryId[c.id] = c.name;
        }
      }

      final entities = courseData ?? const <CourseEntity>[];
      final items =
          entities.map((e) => _toItem(e, nameByCategoryId)).toList(
                growable: false,
              );
      emit(state.copyWith(
        isLoading: false,
        courses: items,
        clearError: true,
      ));
    } catch (e) {
      // Surface parsing / type-cast failures (e.g. an unexpected field
      // shape from a Moodle upgrade) as a user-friendly message instead
      // of the raw exception text — the spec explicitly forbids crashes
      // and bad UX on bad payloads.
      final friendly = e is FormatException || e is TypeError
          ? "Couldn't read the server response. Please try again."
          : e.toString();
      emit(state.copyWith(
        isLoading: false,
        errorMessage: friendly,
      ));
    }
  }

  /// Translate a [CourseEntity] from the domain layer into the
  /// UI-shaped [MyCourseItem] the existing widgets already consume.
  ///
  /// [nameByCategoryId] joins `CourseEntity.categoryId` to the category
  /// name fetched via `core_course_get_categories`. When the lookup
  /// misses (e.g. the categories call failed), the pill falls back to
  /// the course shortname — and finally to "Course" so the UI never
  /// crashes on an empty string.
  MyCourseItem _toItem(
    CourseEntity e,
    Map<int, String> nameByCategoryId,
  ) {
    final categoryName = nameByCategoryId[e.categoryId] ?? '';
    final pill = categoryName.isNotEmpty
        ? categoryName
        : (e.shortname.isNotEmpty ? e.shortname : 'Course');
    return MyCourseItem(
      id: e.id.toString(),
      title: e.fullname,
      category: pill,
      categoryId: e.categoryId,
      categoryName: categoryName,
      shortname: e.shortname,
      colorSeed: _colorSeedForId(e.id.toString()),
      isLocked: !e.visible,
      progress: e.progress,
      overviewUrl: e.overviewUrl,
      startDate: e.startDate,
      endDate: e.endDate,
      visible: e.visible,
    );
  }

  void setStatusFilter(MyCoursesStatusFilter filter) {
    if (filter == state.statusFilter) return;
    emit(state.copyWith(statusFilter: filter));
  }

  void setSortOrder(MyCoursesSortOrder order) {
    if (order == state.sortOrder) return;
    emit(state.copyWith(sortOrder: order));
  }

  void toggleViewMode() {
    emit(state.copyWith(
      viewMode: state.viewMode == MyCoursesViewMode.list
          ? MyCoursesViewMode.grid
          : MyCoursesViewMode.list,
    ));
  }

  void setSearchQuery(String query) {
    if (query == state.searchQuery) return;
    emit(state.copyWith(searchQuery: query));
  }

  void dismissError() {
    if (state.errorMessage == null) return;
    emit(state.copyWith(clearError: true));
  }
}