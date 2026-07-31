import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_section_entity.dart';

/// Repository contract for the course contents feature.
///
/// The presentation layer asks for the contents of a single course;
/// the implementation lives in the data layer and is responsible for
/// the REST call, JSON parsing, and model→entity mapping.
abstract class CourseContentsRepository {
  /// Fetches the sections + modules of the course with [courseId].
  ///
  /// Calls Moodle's `core_course_get_contents` REST function. The
  /// token is read from [LocalStorage] inside the implementation and
  /// supplied as part of the request.
  Future<Result<List<CourseSectionEntity>>> getContents(int courseId);
}
