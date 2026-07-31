// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_boilerplate_data/feature_my_courses/models/course_module_model.dart';
import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_section_entity.dart';

part 'course_section_model.freezed.dart';
part 'course_section_model.g.dart';

/// Data model for a Moodle course section returned by
/// `core_course_get_contents`.
///
/// The response is a bare JSON array of these objects (no wrapper).
@freezed
class CourseSectionModel with _$CourseSectionModel {
  /// Creates a [CourseSectionModel].
  const factory CourseSectionModel({
    /// Moodle section id.
    @JsonKey(name: 'id') required int id,

    /// Section name (e.g. "General").
    @JsonKey(name: 'name') @Default('') String name,

    /// HTML summary text.
    @JsonKey(name: 'summary') @Default('') String summary,

    /// Summary format (1 = HTML, 0 = Moodle, 2 = plain, 4 = Markdown).
    @JsonKey(name: 'summaryformat') @Default(1) int summaryFormat,

    /// Visibility (0/1).
    @JsonKey(name: 'visible') @Default(1) int visible,

    /// Section position on the course page (0 = top).
    @JsonKey(name: 'section') @Default(0) int order,

    /// Modules in this section.
    @JsonKey(name: 'modules')
    @Default(<CourseModuleModel>[])
    List<CourseModuleModel> modules,
  }) = _CourseSectionModel;

  /// Creates a [CourseSectionModel] from JSON.
  factory CourseSectionModel.fromJson(Map<String, dynamic> json) =>
      _$CourseSectionModelFromJson(json);
}

/// Converts a [CourseSectionModel] into the UI-facing entity.
extension CourseSectionModelX on CourseSectionModel {
  /// Maps a data-layer model into a domain entity.
  CourseSectionEntity toEntity() {
    return CourseSectionEntity(
      id: id,
      name: name,
      summary: summary,
      summaryFormat: summaryFormat,
      visible: visible != 0,
      order: order,
      modules: modules.map((m) => m.toEntity()).toList(growable: false),
    );
  }
}
