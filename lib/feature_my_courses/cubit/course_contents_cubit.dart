import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_boilerplate/feature_my_courses/cubit/course_contents_state.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';

/// Cubit for the Course Contents tab on the course detail page.
///
/// Owns the loading/error/sections state for one course. [load] does the
/// initial fetch, [refresh] mirrors it for pull-to-refresh (with the
/// same behaviour — the current Course Contents tab doesn't have a
/// pull-to-refresh scroller, but the API is here for future use).
class CourseContentsCubit extends Cubit<CourseContentsState> {
  /// Creates a [CourseContentsCubit] backed by [GetCourseContentsUseCase].
  CourseContentsCubit({
    required GetCourseContentsUseCase getCourseContentsUseCase,
    required LocalStorage localStorage,
  })  : _getCourseContentsUseCase = getCourseContentsUseCase,
        _localStorage = localStorage,
        super(const CourseContentsState());

  final GetCourseContentsUseCase _getCourseContentsUseCase;
  final LocalStorage _localStorage;

  /// Course id used by the most recent load. Stored so the Retry button
  /// in the error view can re-trigger with the same id.
  int _courseId = 0;

  /// Public read-only accessor for [courseId]. Used by widgets that
  /// need to retry the last fetch (e.g. the contents list error view).
  int get courseIdForRetry => _courseId;

  /// Returns the user's REST token so the UI can append it to
  /// `fileurl` when launching file previews / downloads.
  Future<String> getTokenForLaunches() async {
    final (stored, _) = await _localStorage.get<String>('token');
    return stored ?? '5dc0f086abc4b82a1562b01a20637705';
  }

  /// Fetch the contents for [courseId] (sets loading state, replaces list
  /// on success, leaves existing list intact on error).
  Future<void> load(int courseId) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    await _fetch(courseId);
  }

  /// Re-fetch without flipping the loading indicator (used by any
  /// future pull-to-refresh gesture on this tab).
  Future<void> refresh(int courseId) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    await _fetch(courseId);
  }

  Future<void> _fetch(int courseId) async {
    _courseId = courseId;
    try {
      final (data, failure) =
          await _getCourseContentsUseCase(courseId);
      if (failure != null) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ));
        return;
      }
      final sections = data ?? const <CourseSectionEntity>[];
      emit(state.copyWith(
        isLoading: false,
        sections: sections,
        clearError: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
