import 'package:meta/meta.dart';

/// Pure-Dart representation of a Moodle course, used by the UI layer.
///
/// Only fields the My Courses screen actually consumes are exposed;
/// raw API fields stay in the data layer's `CourseModel`.
@immutable
class CourseEntity {
  /// Moodle course id (as int; the API may return it as a numeric string).
  final int id;

  /// Human-readable course name shown in the card title row.
  final String fullname;

  /// Short code shown next to / instead of the full name in compact UIs.
  final String shortname;

  /// Display name (e.g. "AIDLC - Fall 2026 (Section 1)"). May equal
  /// [fullname] on the source API when no override is set.
  final String displayname;

  /// Plain-text summary shown when the user opens the course.
  final String summary;

  /// Category id (raw; presentation layer can decide whether to render it).
  final int categoryId;

  /// 0–100 progress percentage (null if the API doesn't supply one).
  final double? progress;

  /// URL of the course overview image, if any.
  final String? overviewUrl;

  /// Whether the course is visible to the user. Hidden courses come back
  /// with `visible: 0`; the UI uses this to decide whether to grey out
  /// the card or hide it entirely.
  final bool visible;

  /// Whether the user is currently enrolled (`enrolledusercount` is just
  /// a heuristic — the API actually returns this implicitly via
  /// `core_enrol_get_users_courses`).
  final bool isEnrolled;

  /// Course start date (milliseconds since epoch, per Moodle convention).
  final DateTime? startDate;

  /// Course end date (milliseconds since epoch, per Moodle convention).
  final DateTime? endDate;

  /// Creates a [CourseEntity].
  const CourseEntity({
    required this.id,
    required this.fullname,
    required this.shortname,
    required this.displayname,
    required this.summary,
    required this.categoryId,
    required this.visible,
    required this.isEnrolled,
    this.progress,
    this.overviewUrl,
    this.startDate,
    this.endDate,
  });

  /// Returns a copy of this entity with the given fields replaced.
  CourseEntity copyWith({
    int? id,
    String? fullname,
    String? shortname,
    String? displayname,
    String? summary,
    int? categoryId,
    double? progress,
    String? overviewUrl,
    bool? visible,
    bool? isEnrolled,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CourseEntity(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      shortname: shortname ?? this.shortname,
      displayname: displayname ?? this.displayname,
      summary: summary ?? this.summary,
      categoryId: categoryId ?? this.categoryId,
      progress: progress ?? this.progress,
      overviewUrl: overviewUrl ?? this.overviewUrl,
      visible: visible ?? this.visible,
      isEnrolled: isEnrolled ?? this.isEnrolled,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CourseEntity &&
        other.id == id &&
        other.fullname == fullname &&
        other.shortname == shortname &&
        other.displayname == displayname &&
        other.summary == summary &&
        other.categoryId == categoryId &&
        other.progress == progress &&
        other.overviewUrl == overviewUrl &&
        other.visible == visible &&
        other.isEnrolled == isEnrolled &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode => Object.hash(
        id,
        fullname,
        shortname,
        displayname,
        summary,
        categoryId,
        progress,
        overviewUrl,
        visible,
        isEnrolled,
        startDate,
        endDate,
      );

  @override
  String toString() =>
      'CourseEntity{id: $id, fullname: $fullname, shortname: $shortname}';
}