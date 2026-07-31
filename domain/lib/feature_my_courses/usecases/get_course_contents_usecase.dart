import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_section_entity.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/repositories/course_contents_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fetching the sections + modules of a single course.
///
/// Delegates straight to [CourseContentsRepository.getContents]; kept
/// as a separate class so the cubit depends on a narrow interface.
@injectable
class GetCourseContentsUseCase {
  /// Creates a new [GetCourseContentsUseCase].
  const GetCourseContentsUseCase(this._repository);

  final CourseContentsRepository _repository;

  /// Execute the use case.
  Future<Result<List<CourseSectionEntity>>> call(int courseId) =>
      _repository.getContents(courseId);
}
