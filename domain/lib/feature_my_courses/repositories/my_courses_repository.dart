import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_entity.dart';

/// Repository contract for the My Courses feature.
///
/// Defines the call the presentation layer can make to fetch the courses
/// the current user is enrolled in. The implementation lives in the data
/// layer and is responsible for talking to Moodle, parsing JSON, and
/// mapping models into [CourseEntity] objects.
abstract class MyCoursesRepository {
  /// Returns the list of courses the current user is enrolled in.
  ///
  /// The call is performed against Moodle's `core_enrol_get_users_courses`
  /// REST function. The auth [token] and Moodle [userId] are supplied by
  /// the caller (in practice, [GetMyCoursesUseCase]); the repository does
  /// **not** read them from storage — that responsibility belongs to the
  /// use case so the layering stays clean.
  Future<Result<List<CourseEntity>>> getMyCourses({
    required String token,
    required int userId,
  });
}