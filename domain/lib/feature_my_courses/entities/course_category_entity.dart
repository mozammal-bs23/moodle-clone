import 'package:meta/meta.dart';

/// Pure-Dart representation of a Moodle course category returned by
/// `core_course_get_categories`.
///
/// We only keep the fields the UI actually consumes: the id (used to
/// join a course's `categoryid` to a category name) and the localised
/// display name.
@immutable
class CourseCategoryEntity {
  /// Moodle category id.
  final int id;

  /// Display name (e.g. `Category 1`, `Miscellaneous`).
  final String name;

  /// Moodle category id of the parent category, or `0` for a top-level
  /// category. Surfaced for completeness — not currently rendered.
  final int parentId;

  /// Creates a [CourseCategoryEntity].
  const CourseCategoryEntity({
    required this.id,
    required this.name,
    required this.parentId,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CourseCategoryEntity &&
        other.id == id &&
        other.name == name &&
        other.parentId == parentId;
  }

  @override
  int get hashCode => Object.hash(id, name, parentId);

  @override
  String toString() => 'CourseCategoryEntity{id: $id, name: $name}';
}
