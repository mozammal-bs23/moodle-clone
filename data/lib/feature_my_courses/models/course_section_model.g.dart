// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseSectionModelImpl _$$CourseSectionModelImplFromJson(
  Map<String, dynamic> json,
) => _$CourseSectionModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  summary: json['summary'] as String? ?? '',
  summaryFormat: (json['summaryformat'] as num?)?.toInt() ?? 1,
  visible: (json['visible'] as num?)?.toInt() ?? 1,
  order: (json['section'] as num?)?.toInt() ?? 0,
  modules:
      (json['modules'] as List<dynamic>?)
          ?.map((e) => CourseModuleModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CourseModuleModel>[],
);

Map<String, dynamic> _$$CourseSectionModelImplToJson(
  _$CourseSectionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'summary': instance.summary,
  'summaryformat': instance.summaryFormat,
  'visible': instance.visible,
  'section': instance.order,
  'modules': instance.modules,
};
