import 'package:meta/meta.dart';

import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_module_entity.dart';

/// Pure-Dart representation of a course section returned by
/// `core_course_get_contents`.
///
/// A course is grouped into one or more sections (e.g. "General",
/// "New section"), each containing zero or more modules.
@immutable
class CourseSectionEntity {
  /// Moodle section id.
  final int id;

  /// Section name (e.g. "General", "Week 1").
  final String name;

  /// HTML summary text (may contain markup).
  final String summary;

  /// Summary format — `1` for HTML, `0` for Moodle auto-format, `2`
  /// for plain text, `4` for Markdown.
  final int summaryFormat;

  /// Whether the section is visible to the user.
  final bool visible;

  /// Section position on the course page (0 = top).
  final int order;

  /// Modules in this section, in their display order.
  final List<CourseModuleEntity> modules;

  /// Creates a [CourseSectionEntity].
  const CourseSectionEntity({
    required this.id,
    required this.name,
    required this.summary,
    required this.summaryFormat,
    required this.visible,
    required this.order,
    this.modules = const <CourseModuleEntity>[],
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CourseSectionEntity &&
        other.id == id &&
        other.name == name &&
        other.summary == summary &&
        other.summaryFormat == summaryFormat &&
        other.visible == visible &&
        other.order == order &&
        other.modules == modules;
  }

  @override
  int get hashCode => Object.hash(
        id,
        name,
        summary,
        summaryFormat,
        visible,
        order,
        Object.hashAll(modules),
      );

  @override
  String toString() =>
      'CourseSectionEntity{id: $id, name: $name, modules: ${modules.length}}';
}
