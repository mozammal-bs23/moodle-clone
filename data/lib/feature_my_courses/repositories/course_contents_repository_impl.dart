import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/datasources/course_contents_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/models/course_section_model.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:injectable/injectable.dart';

/// Implementation of [CourseContentsRepository].
///
/// Reads the auth token from [LocalStorage] (falling back to the demo
/// credentials declared in `MyCoursesRepositoryImpl`), calls the remote
/// data source, and maps the returned [CourseSectionModel]s into
/// [CourseSectionEntity]s.
@LazySingleton(as: CourseContentsRepository)
class CourseContentsRepositoryImpl implements CourseContentsRepository {
  /// Creates a new [CourseContentsRepositoryImpl].
  CourseContentsRepositoryImpl({
    required CourseContentsRemoteDatasource remoteDatasource,
    required LocalStorage localStorage,
  })  : _remoteDatasource = remoteDatasource,
        _localStorage = localStorage;

  final CourseContentsRemoteDatasource _remoteDatasource;
  final LocalStorage _localStorage;

  @override
  Future<Result<List<CourseSectionEntity>>> getContents(int courseId) async {
    final (tokenResult, _) = await _localStorage
        .get<String>(MyCoursesConstants.tokenKey);
    final token = tokenResult ?? MyCoursesConstants.fallbackToken;

    try {
      final response = await _remoteDatasource.getContents(
        wstoken: token,
        courseid: courseId,
      );
      final entities = response.map((m) => m.toEntity()).toList();
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
