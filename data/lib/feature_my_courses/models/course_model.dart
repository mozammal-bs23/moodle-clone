// ignore_for_file: invalid_annotation_target
import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

/// Data model for a Moodle course returned by
/// `core_enrol_get_users_courses`.
///
/// Models exist only in the data layer — they handle raw JSON parsing
/// (including the loosely-typed fields Moodle returns) and convert to
/// [CourseEntity] for the rest of the app.
///
/// Field notes (Moodle returns these as JSON):
///   * `id` comes back as an int, but be tolerant of a numeric string
///     (older endpoints occasionally wrap it). See [IdParser].
///   * `overviewfiles` is an array of file objects; we extract the first
///     one's `fileurl` to a flat `overviewUrl`.
///   * `courseimage` is a flat URL string (Moodle 4.x+).
///   * `progress` is a nullable double (0–100). Older Moodle versions
///     don't return it at all, in which case we leave it null.
///   * `visible` is `0` or `1` rather than a bool.
@freezed
class CourseModel with _$CourseModel {
  /// Creates a [CourseModel].
  const factory CourseModel({
    /// Numeric id (parsed tolerantly — see [IdParser]).
    required int id,

    /// Human-readable course name.
    @JsonKey(name: 'fullname') required String fullname,

    /// Short course code.
    @JsonKey(name: 'shortname') required String shortname,

    /// Display name (may equal fullname).
    @JsonKey(name: 'displayname') @Default('') String displayname,

    /// HTML-stripped plain-text summary.
    @JsonKey(name: 'summary') @Default('') String summary,

    /// Category id. Moodle's `core_enrol_get_users_courses` returns this
    /// as the field name `category` (not `categoryid` — that's the
    /// name used by `core_course_get_courses`). We map both shapes for
    /// robustness across endpoints.
    @JsonKey(name: 'category', readValue: _readCategoryId) @Default(0)
    int categoryId,

    /// 0–100 progress percentage.
    @JsonKey(name: 'progress') double? progress,

    /// `overviewfiles` flattened to a single image URL.
    @JsonKey(name: 'overviewfiles') @Default(<OverviewFile>[]) List<OverviewFile> overviewfiles,

    /// Course image URL (Moodle 4.x).
    @JsonKey(name: 'courseimage') String? courseimage,

    /// Visibility (0/1).
    @JsonKey(name: 'visible') @Default(1) int visible,

    /// Start date as milliseconds since epoch.
    @JsonKey(name: 'startdate') int? startdate,

    /// End date as milliseconds since epoch.
    @JsonKey(name: 'enddate') int? enddate,
  }) = _CourseModel;

  /// Creates a [CourseModel] from JSON.
  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
}

/// Reads the category id from the JSON, accepting either `category` or
/// `categoryid` depending on which Moodle endpoint produced the payload.
Object? _readCategoryId(Map<dynamic, dynamic> json, String key) {
  if (json.containsKey('category') && json['category'] is num) {
    return json['category'];
  }
  if (json.containsKey('categoryid') && json['categoryid'] is num) {
    return json['categoryid'];
  }
  return null;
}

/// Minimal shape of the file objects inside `overviewfiles`.
///
/// We only model the field we actually consume (the file URL); the rest
/// of the object is ignored.
@freezed
class OverviewFile with _$OverviewFile {
  /// Creates an [OverviewFile].
  const factory OverviewFile({
    /// Direct URL to the file.
    @JsonKey(name: 'fileurl') String? fileurl,
  }) = _OverviewFile;

  /// Creates an [OverviewFile] from JSON.
  factory OverviewFile.fromJson(Map<String, dynamic> json) =>
      _$OverviewFileFromJson(json);
}

/// Converts a [CourseModel] into the UI-facing [CourseEntity].
extension CourseModelX on CourseModel {
  /// Maps a data-layer model into a domain entity.
  CourseEntity toEntity() {
    // Prefer `courseimage` (Moodle 4.x); fall back to the first
    // overview file's URL (Moodle 3.x).
    final String? imageUrl = courseimage ??
        (overviewfiles.isNotEmpty ? overviewfiles.first.fileurl : null);

    return CourseEntity(
      id: id,
      fullname: fullname,
      shortname: shortname,
      displayname: displayname.isNotEmpty ? displayname : fullname,
      summary: summary,
      categoryId: categoryId,
      progress: progress,
      overviewUrl: imageUrl,
      visible: visible != 0,
      // The endpoint we're calling only returns courses the user is
      // enrolled in, so by definition `isEnrolled` is always true here.
      isEnrolled: true,
      // Moodle returns 0 when start/end dates are unset in the course
      // settings. If we parsed 0 as a real timestamp we'd end up with
      // 1970-01-01, which would make the "In progress" filter drop the
      // course as already-past. Treat 0 as null.
      startDate: (startdate == null || startdate == 0)
          ? null
          : DateTime.fromMillisecondsSinceEpoch(startdate!),
      endDate: (enddate == null || enddate == 0)
          ? null
          : DateTime.fromMillisecondsSinceEpoch(enddate!),
    );
  }
}