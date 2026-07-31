import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:flutter_boilerplate_data/feature_my_courses/models/course_section_model.dart';

part 'course_contents_remote_datasource.g.dart';

/// Remote data source for the course contents feature.
///
/// Wraps the Moodle REST call to `core_course_get_contents`. The token
/// is read from `LocalStorage` before each call (see the repository
/// implementation) and passed in via the body — we don't hardcode it
/// here so the data source stays a pure HTTP boundary.
///
/// Same form-urlencoded content-type as the other Moodle endpoint.
@RestApi()
abstract class CourseContentsRemoteDatasource {
  /// Creates a [CourseContentsRemoteDatasource].
  factory CourseContentsRemoteDatasource(
    Dio dio, {
    String baseUrl,
  }) = _CourseContentsRemoteDatasource;

  /// Calls `core_course_get_contents` and returns the list of section
  /// models (each containing its modules and their file contents).
  ///
  /// [token] — Moodle REST token (wstoken).
  /// [courseId] — the id of the course to fetch contents for.
  @POST('/')
  Future<List<CourseSectionModel>> getContents({
    @Header('Content-Type')
    String contentType = 'application/x-www-form-urlencoded',

    /// The Moodle REST function name.
    @Field('wsfunction')
    String wsfunction = 'core_course_get_contents',

    /// Response format — always `json` for the modern endpoints.
    @Field('moodlewsrestformat')
    String moodlewsrestformat = 'json',

    /// REST token.
    @Field('wstoken') required String wstoken,

    /// Target course id.
    @Field('courseid') required int courseid,
  });
}
