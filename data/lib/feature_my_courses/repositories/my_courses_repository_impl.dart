import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/datasources/my_courses_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/models/course_model.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:injectable/injectable.dart';

/// Implementation of [MyCoursesRepository].
///
/// Receives the auth token + user id from the caller (the use case —
/// which is responsible for resolving them from [LocalStorage]). Talks
/// to the remote data source and maps the returned [CourseModel]s into
/// [CourseEntity]s.
@LazySingleton(as: MyCoursesRepository)
class MyCoursesRepositoryImpl implements MyCoursesRepository {
  /// Creates a new [MyCoursesRepositoryImpl].
  MyCoursesRepositoryImpl({
    required MyCoursesRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  final MyCoursesRemoteDatasource _remoteDatasource;

  @override
  Future<Result<List<CourseEntity>>> getMyCourses({
    required String token,
    required int userId,
  }) async {
    try {
      final response = await _remoteDatasource.getMyCourses(
        wsfunction: 'core_enrol_get_users_courses',
        moodlewsrestformat: 'json',
        wstoken: token,
        userid: userId,
      );
      final entities = response.map((model) => model.toEntity()).toList();
      return ResultHelper.success(entities);
    } on DioException catch (e) {
      return ResultX.failure(_mapDioError(e));
    } catch (e, st) {
      return ResultX.failure(_mapUnknownError(e, st));
    }
  }

  NetworkFailure _mapDioError(DioException e) {
    return NetworkFailure(
      message: e.message ?? 'Network error',
      statusCode: e.response?.statusCode,
      responseBody: e.response?.toString(),
    );
  }

  UnknownFailure _mapUnknownError(Object e, StackTrace st) {
    return UnknownFailure(
      message: 'Unexpected error: $e',
      exception: e,
      stackTrace: st,
    );
  }
}