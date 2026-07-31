import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flutter_boilerplate_data/feature_my_courses/models/course_category_model.dart';

part 'course_categories_remote_datasource.g.dart';

/// Remote data source for the course categories feature.
///
/// Wraps the Moodle REST call to `core_course_get_categories`. The
/// token is read from `LocalStorage` by the use case and passed in via
/// the body — we don't hardcode it here so the data source stays a pure
/// HTTP boundary.
@RestApi()
abstract class CourseCategoriesRemoteDatasource {
  /// Creates a [CourseCategoriesRemoteDatasource].
  factory CourseCategoriesRemoteDatasource(
    Dio dio, {
    String baseUrl,
  }) = _CourseCategoriesRemoteDatasource;

  /// Calls `core_course_get_categories` and returns the list of
  /// category models.
  ///
  /// [token] — Moodle REST token (wstoken).
  @POST('/')
  Future<List<CourseCategoryModel>> getCategories({
    @Header('Content-Type') String contentType = 'application/x-www-form-urlencoded',

    /// The Moodle REST function name.
    @Field('wsfunction') String wsfunction = 'core_course_get_categories',

    /// Response format — always `json` for the modern endpoints.
    @Field('moodlewsrestformat') String moodlewsrestformat = 'json',

    /// REST token.
    @Field('wstoken') required String wstoken,

    /// Optional category id to filter to a single subtree. We pass
    /// `0` (= root) so the response contains every visible category.
    @Field('criteria[0][key]') String criteriaKey = 'parent',
    @Field('criteria[0][value]') String criteriaValue = '0',
  });
}