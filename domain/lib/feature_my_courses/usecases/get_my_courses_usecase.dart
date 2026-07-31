import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/constants/my_courses_constants.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_entity.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/repositories/my_courses_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fetching the current user's enrolled courses.
///
/// Responsibilities (per the spec):
///   1. Retrieve the auth token from [LocalStorage].
///   2. Retrieve the user id from [LocalStorage].
///   3. Forward the resolved credentials to [MyCoursesRepository].
///   4. Return the list of [CourseEntity] from the repository, or the
///      underlying [AppFailure] on error.
///
/// If SharedPreferences has no token / user id, the documented fallback
/// credentials (see README) are used so the demo build still works.
@injectable
class GetMyCoursesUseCase {
  /// Creates a new [GetMyCoursesUseCase].
  const GetMyCoursesUseCase(this._repository, this._localStorage);

  final MyCoursesRepository _repository;
  final LocalStorage _localStorage;

  /// Execute the use case.
  Future<Result<List<CourseEntity>>> call() async {
    final (tokenResult, _) = await _localStorage.get<String>('token');
    final (userIdResult, _) = await _localStorage.get<int>('userid');

    final String token = tokenResult ?? MyCoursesConstants.fallbackToken;
    final int userId = userIdResult ?? MyCoursesConstants.fallbackUserId;

    return _repository.getMyCourses(token: token, userId: userId);
  }
}