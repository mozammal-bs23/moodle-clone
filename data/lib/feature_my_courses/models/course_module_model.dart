// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_boilerplate_data/feature_my_courses/models/course_content_file_model.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_module_entity.dart';

part 'course_module_model.freezed.dart';
part 'course_module_model.g.dart';

/// Data model for a Moodle course module returned by
/// `core_course_get_contents`.
///
/// Models exist only in the data layer — they handle raw JSON parsing
/// and convert to [CourseModuleEntity] for the rest of the app.
///
/// Field notes:
///   * `modname` is the activity type identifier (`assign`, `quiz`,
///     `page`, `forum`, `url`, `resource`, `folder`, `label`, `lti`).
///   * `dates` is a JSON array — each entry has a `label` ("Opened:" /
///     "Due:") and `dataid` ("allowsubmissionsfromdate" / "duedate")
///     plus a `timestamp` (Unix seconds). We flatten that array to
///     `dateStart` / `dateEnd` in `toEntity()` based on `dataid`,
///     which is the most reliable selector across modules.
@freezed
class CourseModuleModel with _$CourseModuleModel {
  /// Creates a [CourseModuleModel].
  const factory CourseModuleModel({
    /// Moodle course-module id.
    @JsonKey(name: 'id') required int id,

    /// Display name (e.g. "Test Assignment").
    @JsonKey(name: 'name') required String name,

    /// Module type identifier (e.g. assign, quiz, page).
    @JsonKey(name: 'modname') @Default('') String modname,

    /// Activity instance id.
    @JsonKey(name: 'instance') @Default(0) int instance,

    /// Optional launch URL for the activity.
    @JsonKey(name: 'url') String? url,

    /// Module-specific icon URL provided by the Moodle theme
    /// (e.g. `theme/image.php/mb2nl/forum/.../monologo`). Surfaced to
    /// the UI so each module renders the exact icon the site
    /// configured instead of relying on a hard-coded glyph map.
    @JsonKey(name: 'modicon') String? modicon,

    /// Optional activity badge (e.g. `{"badgecontent":"MP4"}` for file
    /// modules). The UI renders this verbatim as the file chip label —
    /// no client-side derivation from mimetype or filename.
    ///
    /// The Moodle API returns `[]` (empty array) for modules that don't
    /// supply a badge and `{...}` (object) for ones that do. We treat
    /// the array as "no badge" so the model stays nullable.
    @JsonKey(name: 'activitybadge', readValue: _readActivityBadge)
    ActivityBadgeModel? activityBadge,

    /// Whether the module is visible (0/1).
    @JsonKey(name: 'visible') @Default(1) int visible,

    /// Whether the current user can see the module (boolean in the
    /// live Moodle response — older docs show 0/1). Accept both shapes
    /// by keeping the model field nullable and normalising in
    /// [toEntity].
    @JsonKey(name: 'uservisible') bool? userVisible,

    /// Files attached to this module. Always defaulted to `[]` so the
    /// UI doesn't have to null-check.
    @JsonKey(name: 'contents')
    @Default(<CourseContentFileModel>[])
    List<CourseContentFileModel> contents,

    /// Per-event date labels and timestamps returned by Moodle.
    /// We pick the open/close values out of this in [toEntity].
    @JsonKey(name: 'dates')
    @Default(<DateLabelModel>[])
    List<DateLabelModel> dates,

    /// Completion state for the current user. Moodle returns `0` (not
    /// completed) or `1` (completed). We map to a nullable bool so the
    /// UI can decide what to render (or nothing at all when the course
    /// doesn't track completion).
    @JsonKey(name: 'completion') int? completion,
  }) = _CourseModuleModel;

  /// Creates a [CourseModuleModel] from JSON.
  factory CourseModuleModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModuleModelFromJson(json);
}

/// One entry in the module's `dates[]` array.
///
/// Moodle returns an array of these per module; the most reliable way
/// to identify which one is the open / close date is the `dataid`
/// string, e.g. `allowsubmissionsfromdate` (open) or `duedate` (close).
@freezed
class DateLabelModel with _$DateLabelModel {
  /// Creates a [DateLabelModel].
  const factory DateLabelModel({
    /// Human-readable label, e.g. "Opened:" or "Due:".
    @JsonKey(name: 'label') @Default('') String label,

    /// Unix seconds timestamp.
    @JsonKey(name: 'timestamp') int? timestamp,

    /// Identifier for the type of date, e.g. `allowsubmissionsfromdate`
    /// or `duedate`. We use this to tell apart the two timestamps the
    /// API exposes for assignments and similar modules.
    @JsonKey(name: 'dataid') @Default('') String dataid,
  }) = _DateLabelModel;

  /// Creates a [DateLabelModel] from JSON.
  factory DateLabelModel.fromJson(Map<String, dynamic> json) =>
      _$DateLabelModelFromJson(json);
}

/// Reads the `activitybadge` field as either an object (when present)
/// or `null` (when the API sent the empty-array placeholder). Moodle
/// returns `[]` for modules that don't have a badge and `{...}` for
/// ones that do — without this shim freezed tries to cast the empty
/// list to a `Map` and throws.
Object? _readActivityBadge(
  Map<dynamic, dynamic> json,
  String key,
) {
  final value = json[key];
  if (value is Map) return value;
  return null;
}

/// Optional `activitybadge` object supplied by some modules (e.g. file
/// modules). The `badgecontent` string is rendered verbatim as the
/// file-chip label — no client-side derivation from mimetype or
/// filename, so the UI matches whatever the Moodle theme configured.
@freezed
class ActivityBadgeModel with _$ActivityBadgeModel {
  /// Creates an [ActivityBadgeModel].
  const factory ActivityBadgeModel({
    /// Short label rendered on the chip, e.g. `MP4`, `PDF`.
    @JsonKey(name: 'badgecontent') @Default('') String badgeContent,

    /// Style identifier (`badge-none`, etc.). Read for completeness but
    /// not currently surfaced — the UI uses a single chip style.
    @JsonKey(name: 'badgestyle') @Default('') String badgeStyle,
  }) = _ActivityBadgeModel;

  /// Creates an [ActivityBadgeModel] from JSON.
  factory ActivityBadgeModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityBadgeModelFromJson(json);
}

/// Converts a [CourseModuleModel] into the UI-facing entity.
extension CourseModuleModelX on CourseModuleModel {
  /// Maps a data-layer model into a domain entity.
  CourseModuleEntity toEntity() {
    // Pick out the open / close dates by `dataid`. Some modules only
    // expose one of the two; both are nullable in the entity.
    DateTime? dateStart;
    DateTime? dateEnd;
    for (final d in dates) {
      final ts = d.timestamp;
      if (ts == null) continue;
      switch (d.dataid) {
        case 'allowsubmissionsfromdate':
          dateStart = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
        case 'duedate':
          dateEnd = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
      }
    }
    // Pass the badge content verbatim from the API. If absent (most
    // modules don't supply `activitybadge`), the entity field stays
    // null and the UI renders no chip — strictly mirroring the
    // upstream payload rather than guessing a label.
    final badgeContent = activityBadge?.badgeContent;
    final badgeForEntity = (badgeContent != null && badgeContent.isNotEmpty)
        ? badgeContent
        : null;

    return CourseModuleEntity(
      id: id,
      name: name,
      modname: modname,
      instance: instance,
      url: url,
      modiconUrl: (modicon != null && modicon!.isNotEmpty) ? modicon : null,
      activityBadgeContent: badgeForEntity,
      visible: visible != 0,
      // `uservisible` comes back as a real boolean in modern Moodle
      // responses (`true`/`false`). When null (older / edge sites)
      // fall back to the `visible` field so we never block a module
      // the user can actually see.
      userVisible: userVisible ?? (visible != 0),
      contents: contents.map((c) => c.toEntity()).toList(growable: false),
      dateStart: dateStart,
      dateEnd: dateEnd,
      // Moodle sends `completion` as 0 / 1. We treat anything other
      // than 1 as "not completed" (or unknown when the course doesn't
      // track completion at all — we surface `null` in that case so
      // the UI doesn't paint a false-positive checkmark).
      completion: completion == 1 ? true : (completion == 0 ? false : null),
      contentsCount: contents.isEmpty ? null : contents.length,
    );
  }
}
