import 'package:meta/meta.dart';

import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_content_file_entity.dart';

/// Pure-Dart representation of a single course module (activity or
/// resource) returned by `core_course_get_contents`.
///
/// The `modname` field carries the module type identifier (e.g.
/// `assign`, `quiz`, `page`, `forum`, `url`, `resource`, `folder`,
/// `label`, `lti`). The UI uses it to choose an icon.
@immutable
class CourseModuleEntity {
  /// Moodle course-module id (`cmid`).
  final int id;

  /// Display name of the module (e.g. "Test Assignment").
  final String name;

  /// Module type identifier (e.g. `assign`, `forum`, `page`).
  final String modname;

  /// Activity instance id (the row in the activity's own table).
  final int instance;

  /// Optional launch URL for the activity.
  final String? url;

  /// Theme-provided icon URL for this module (e.g. forum/assign/page
  /// glyph). Surfaced by `core_course_get_contents` as `modicon`.
  /// When non-null the UI uses a network image; when null the UI falls
  /// back to a static `modname`-driven glyph.
  final String? modiconUrl;

  /// Optional activity badge label, surfaced by the API as
  /// `activitybadge.badgecontent` (e.g. `"MP4"`). When non-null, the
  /// UI renders this verbatim as the file chip label — no
  /// client-side derivation from mimetype or filename.
  final String? activityBadgeContent;

  /// HTML description from the module's settings. Usually empty.
  final String? description;

  /// Whether the module is visible to the user.
  final bool visible;

  /// Whether the current user can see the module (already accounting
  /// for restrictions, group memberships, etc.).
  final bool userVisible;

  /// Files attached to this module. Empty for modules that don't expose
  /// file contents (assign, quiz, forum, url). Non-empty for resource,
  /// folder, page, and similar.
  final List<CourseContentFileEntity> contents;

  /// When the activity opens (e.g. assignment open date).
  final DateTime? dateStart;

  /// When the activity closes (e.g. assignment due date).
  final DateTime? dateEnd;

  /// Moodle completion state for the current user on this module.
  ///
  /// `true` = completed, `false` = in progress / not started, `null` =
  /// either not tracked or not supplied by the API. The UI surfaces a
  /// green checkmark when this is `true`.
  final bool? completion;

  /// Cached count of `contents` for the right-side file-count badge
  /// (e.g. a module exposing three files shows a stack icon with "3").
  /// `null` when the count isn't relevant for the module type.
  final int? contentsCount;

  /// Creates a [CourseModuleEntity].
  const CourseModuleEntity({
    required this.id,
    required this.name,
    required this.modname,
    required this.instance,
    required this.visible,
    required this.userVisible,
    this.url,
    this.modiconUrl,
    this.activityBadgeContent,
    this.description,
    this.contents = const <CourseContentFileEntity>[],
    this.dateStart,
    this.dateEnd,
    this.completion,
    this.contentsCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CourseModuleEntity &&
        other.id == id &&
        other.name == name &&
        other.modname == modname &&
        other.instance == instance &&
        other.url == url &&
        other.modiconUrl == modiconUrl &&
        other.activityBadgeContent == activityBadgeContent &&
        other.description == description &&
        other.visible == visible &&
        other.userVisible == userVisible &&
        other.contents == contents &&
        other.dateStart == dateStart &&
        other.dateEnd == dateEnd &&
        other.completion == completion &&
        other.contentsCount == contentsCount;
  }

  @override
  int get hashCode => Object.hash(
        id,
        name,
        modname,
        instance,
        url,
        modiconUrl,
        activityBadgeContent,
        description,
        visible,
        userVisible,
        Object.hashAll(contents),
        dateStart,
        dateEnd,
        completion,
        contentsCount,
      );

  @override
  String toString() =>
      'CourseModuleEntity{id: $id, name: $name, modname: $modname}';
}
