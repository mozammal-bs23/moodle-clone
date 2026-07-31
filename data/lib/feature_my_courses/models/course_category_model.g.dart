// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseCategoryModelImpl _$$CourseCategoryModelImplFromJson(
  Map<String, dynamic> json,
) => _$CourseCategoryModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  parent: (json['parent'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$CourseCategoryModelImplToJson(
  _$CourseCategoryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'parent': instance.parent,
};
