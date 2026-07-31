// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_boilerplate_domain/feature_my_courses/entities/course_category_entity.dart';

part 'course_category_model.freezed.dart';
part 'course_category_model.g.dart';

/// Data model for a Moodle course category returned by
/// `core_course_get_categories`.
///
/// Same pattern as the other models: lives in the data layer, handles
/// raw JSON parsing, and converts to [CourseCategoryEntity] for the
/// rest of the app.
@freezed
class CourseCategoryModel with _$CourseCategoryModel {
  /// Creates a [CourseCategoryModel].
  const factory CourseCategoryModel({
    /// Numeric id.
    @JsonKey(name: 'id') required int id,

    /// Display name.
    @JsonKey(name: 'name') @Default('') String name,

    /// Parent category id (`0` for top-level).
    @JsonKey(name: 'parent') @Default(0) int parent,
  }) = _CourseCategoryModel;

  /// Creates a [CourseCategoryModel] from JSON.
  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CourseCategoryModelFromJson(json);
}

/// Maps a data-layer model into the domain entity.
extension CourseCategoryModelX on CourseCategoryModel {
  /// Converts this model to a [CourseCategoryEntity].
  CourseCategoryEntity toEntity() {
    return CourseCategoryEntity(
      id: id,
      name: name,
      parentId: parent,
    );
  }
}