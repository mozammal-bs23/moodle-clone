import 'package:meta/meta.dart';

/// Pure-Dart representation of a file attached to a Moodle course module.
///
/// Returned by `core_course_get_contents` inside each module's
/// `contents[]` array. The most common case is one file per file-type
/// module, but `folder` modules can expose many.
@immutable
class CourseContentFileEntity {
  /// Original filename as Moodle stores it (e.g. `intro.pdf`).
  final String filename;

  /// Direct URL to the file. Note this URL requires the requesting
  /// user's `wstoken` appended as `?token=…` for auth.
  final String? fileurl;

  /// MIME type (e.g. `application/pdf`, `video/mp4`). May be null.
  final String? mimetype;

  /// File size in bytes (0 when unknown).
  final int filesize;

  /// Moodle-internal filepath component (usually `/`).
  final String filepath;

  /// When the file was uploaded (UTC).
  final DateTime? timecreated;

  /// When the file was last modified (UTC).
  final DateTime? timemodified;

  /// Creates a [CourseContentFileEntity].
  const CourseContentFileEntity({
    required this.filename,
    required this.filesize,
    required this.filepath,
    this.fileurl,
    this.mimetype,
    this.timecreated,
    this.timemodified,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CourseContentFileEntity &&
        other.filename == filename &&
        other.fileurl == fileurl &&
        other.mimetype == mimetype &&
        other.filesize == filesize &&
        other.filepath == filepath &&
        other.timecreated == timecreated &&
        other.timemodified == timemodified;
  }

  @override
  int get hashCode => Object.hash(
        filename,
        fileurl,
        mimetype,
        filesize,
        filepath,
        timecreated,
        timemodified,
      );

  @override
  String toString() =>
      'CourseContentFileEntity{filename: $filename, mimetype: $mimetype}';
}
