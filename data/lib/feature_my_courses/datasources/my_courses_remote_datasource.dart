import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/models/course_model.dart';
import 'package:retrofit/retrofit.dart';

part 'my_courses_remote_datasource.g.dart';

/// Remote data source for the My Courses feature.
///
/// Wraps the Moodle REST call to `core_enrol_get_users_courses`. The
/// token + user id are read from `LocalStorage` before each call (see
/// the repository implementation) and passed in via the body — we don't
/// hardcode them here so the data source stays a pure HTTP boundary.
///
/// We use Retrofit for the boilerplate but with a twist: this endpoint
/// requires `application/x-www-form-urlencoded` content-type (Moodle's
/// REST convention), which is set via [Options] on the method. The
/// project's shared Dio instance is JSON by default, so the override is
/// necessary per-call.
@RestApi()
abstract class MyCoursesRemoteDatasource {
  /// Creates a [MyCoursesRemoteDatasource].
  ///
  /// [dio] — the shared configured Dio instance.
  /// [baseUrl] — the Moodle REST endpoint, injected as
  /// `@Named('moodleBaseUrl')` from `DIModule`.
  factory MyCoursesRemoteDatasource(
    Dio dio, {
    String baseUrl,
  }) = _MyCoursesRemoteDatasource;

  /// Calls `core_enrol_get_users_courses` and returns the list of
  /// course models.
  ///
  /// [token] — Moodle REST token (wstoken).
  /// [userId] — Moodle user id.
  @POST('/')
  Future<List<CourseModel>> getMyCourses({
    @Header('Content-Type') String contentType = 'application/x-www-form-urlencoded',

    /// The Moodle REST function name.
    @Field('wsfunction') required String wsfunction,

    /// Response format — always `json` for the modern endpoints.
    @Field('moodlewsrestformat') required String moodlewsrestformat,

    /// REST token.
    @Field('wstoken') required String wstoken,

    /// Target user id.
    @Field('userid') required int userid,
  });
}