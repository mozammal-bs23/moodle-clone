// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_content_file_entity.dart';

part 'course_content_file_model.freezed.dart';
part 'course_content_file_model.g.dart';

/// Data model for a file attached to a Moodle course module.
///
/// Returned by `core_course_get_contents` inside each module's
/// `contents[]` array. The data layer is responsible for raw JSON
/// parsing; the UI consumes [CourseContentFileEntity] instead.
@freezed
class CourseContentFileModel with _$CourseContentFileModel {
  /// Creates a [CourseContentFileModel].
  const factory CourseContentFileModel({
    /// Original filename as Moodle stores it.
    @JsonKey(name: 'filename') @Default('') String filename,

    /// Direct URL to the file (requires the requesting user's wstoken).
    @JsonKey(name: 'fileurl') String? fileurl,

    /// MIME type (e.g. application/pdf, video/mp4).
    @JsonKey(name: 'mimetype') String? mimetype,

    /// File size in bytes.
    @JsonKey(name: 'filesize') @Default(0) int filesize,

    /// Moodle-internal filepath component (usually `/`).
    @JsonKey(name: 'filepath') @Default('/') String filepath,

    /// When the file was uploaded (Unix seconds).
    @JsonKey(name: 'timecreated') int? timecreated,

    /// When the file was last modified (Unix seconds).
    @JsonKey(name: 'timemodified') int? timemodified,
  }) = _CourseContentFileModel;

  /// Creates a [CourseContentFileModel] from JSON.
  factory CourseContentFileModel.fromJson(Map<String, dynamic> json) =>
      _$CourseContentFileModelFromJson(json);
}

/// Converts a [CourseContentFileModel] into the UI-facing entity.
extension CourseContentFileModelX on CourseContentFileModel {
  /// Maps a data-layer model into a domain entity.
  CourseContentFileEntity toEntity() {
    return CourseContentFileEntity(
      filename: filename,
      fileurl: fileurl,
      mimetype: mimetype,
      filesize: filesize,
      filepath: filepath,
      // Moodle dates are Unix seconds; DateTime needs milliseconds.
      timecreated: timecreated == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(timecreated! * 1000),
      timemodified: timemodified == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(timemodified! * 1000),
    );
  }
}
