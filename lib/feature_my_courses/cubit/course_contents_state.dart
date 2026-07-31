import 'package:equatable/equatable.dart';

import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_section_entity.dart';

/// State for the Course Contents tab on the course detail page.
///
/// Only owns the rendered shape of the contents (loading flag, error
/// message, list of sections). Filtering/search is out of scope here —
/// the list is short enough that one scroll is the whole picture.
class CourseContentsState extends Equatable {
  /// Creates a [CourseContentsState].
  const CourseContentsState({
    this.isLoading = false,
    this.errorMessage,
    this.sections = const <CourseSectionEntity>[],
  });

  /// Whether a fetch is in progress.
  final bool isLoading;

  /// Human-readable error message from the last failed fetch, if any.
  final String? errorMessage;

  /// Sections returned by the last successful fetch.
  final List<CourseSectionEntity> sections;

  /// Returns a copy of this state with the given fields replaced.
  CourseContentsState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    List<CourseSectionEntity>? sections,
  }) {
    return CourseContentsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      sections: sections ?? this.sections,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, sections];
}
