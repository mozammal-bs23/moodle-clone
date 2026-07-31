import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_category_entity.dart';

/// Repository contract for fetching Moodle course categories.
///
/// Implementation lives in the data layer and is responsible for calling
/// `core_course_get_categories`, parsing the response, and mapping the
/// models into [CourseCategoryEntity] objects.
abstract class CourseCategoriesRepository {
  /// Returns every visible course category on the site.
  ///
  /// The token is supplied by the caller (the use case resolves it from
  /// [LocalStorage] with the documented fallback). The repository does
  /// **not** read SharedPreferences itself.
  Future<Result<List<CourseCategoryEntity>>> getCategories({
    required String token,
  });
}
