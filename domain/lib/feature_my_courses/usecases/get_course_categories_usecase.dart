import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/constants/my_courses_constants.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_category_entity.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/repositories/course_categories_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fetching every visible Moodle course category.
///
/// Responsibilities (mirroring `GetMyCoursesUseCase`):
///   1. Retrieve the auth token from [LocalStorage].
///   2. Forward the resolved credentials to [CourseCategoriesRepository].
///   3. Return the list of [CourseCategoryEntity] from the repository,
///      or the underlying [AppFailure] on error.
///
/// SharedPreferences has no token → the documented fallback is used so
/// the demo build still works.
@injectable
class GetCourseCategoriesUseCase {
  /// Creates a new [GetCourseCategoriesUseCase].
  const GetCourseCategoriesUseCase(this._repository, this._localStorage);

  final CourseCategoriesRepository _repository;
  final LocalStorage _localStorage;

  /// Execute the use case.
  Future<Result<List<CourseCategoryEntity>>> call() async {
    final (tokenResult, _) = await _localStorage.get<String>(
      MyCoursesConstants.tokenKey,
    );
    final String token = tokenResult ?? MyCoursesConstants.fallbackToken;
    return _repository.getCategories(token: token);
  }
}
