import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/datasources/course_categories_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/models/course_category_model.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:injectable/injectable.dart';

/// Implementation of [CourseCategoriesRepository].
///
/// Receives the auth token from the caller (the use case — which is
/// responsible for resolving it from [LocalStorage]). Talks to the
/// remote data source and maps the returned [CourseCategoryModel]s
/// into [CourseCategoryEntity]s.
@LazySingleton(as: CourseCategoriesRepository)
class CourseCategoriesRepositoryImpl
    implements CourseCategoriesRepository {
  /// Creates a new [CourseCategoriesRepositoryImpl].
  CourseCategoriesRepositoryImpl({
    required CourseCategoriesRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  final CourseCategoriesRemoteDatasource _remoteDatasource;

  @override
  Future<Result<List<CourseCategoryEntity>>> getCategories({
    required String token,
  }) async {
    try {
      final response = await _remoteDatasource.getCategories(wstoken: token);
      final entities =
          response.map((m) => m.toEntity()).toList(growable: false);
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