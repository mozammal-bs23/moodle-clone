// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseModuleModelImpl _$$CourseModuleModelImplFromJson(
  Map<String, dynamic> json,
) => _$CourseModuleModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  modname: json['modname'] as String? ?? '',
  instance: (json['instance'] as num?)?.toInt() ?? 0,
  url: json['url'] as String?,
  modicon: json['modicon'] as String?,
  activityBadge: _readActivityBadge(json, 'activitybadge') == null
      ? null
      : ActivityBadgeModel.fromJson(
          _readActivityBadge(json, 'activitybadge') as Map<String, dynamic>,
        ),
  visible: (json['visible'] as num?)?.toInt() ?? 1,
  userVisible: json['uservisible'] as bool?,
  contents:
      (json['contents'] as List<dynamic>?)
          ?.map(
            (e) => CourseContentFileModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <CourseContentFileModel>[],
  dates:
      (json['dates'] as List<dynamic>?)
          ?.map((e) => DateLabelModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DateLabelModel>[],
  completion: (json['completion'] as num?)?.toInt(),
);

Map<String, dynamic> _$$CourseModuleModelImplToJson(
  _$CourseModuleModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'modname': instance.modname,
  'instance': instance.instance,
  'url': instance.url,
  'modicon': instance.modicon,
  'activitybadge': instance.activityBadge,
  'visible': instance.visible,
  'uservisible': instance.userVisible,
  'contents': instance.contents,
  'dates': instance.dates,
  'completion': instance.completion,
};

_$DateLabelModelImpl _$$DateLabelModelImplFromJson(Map<String, dynamic> json) =>
    _$DateLabelModelImpl(
      label: json['label'] as String? ?? '',
      timestamp: (json['timestamp'] as num?)?.toInt(),
      dataid: json['dataid'] as String? ?? '',
    );

Map<String, dynamic> _$$DateLabelModelImplToJson(
  _$DateLabelModelImpl instance,
) => <String, dynamic>{
  'label': instance.label,
  'timestamp': instance.timestamp,
  'dataid': instance.dataid,
};

_$ActivityBadgeModelImpl _$$ActivityBadgeModelImplFromJson(
  Map<String, dynamic> json,
) => _$ActivityBadgeModelImpl(
  badgeContent: json['badgecontent'] as String? ?? '',
  badgeStyle: json['badgestyle'] as String? ?? '',
);

Map<String, dynamic> _$$ActivityBadgeModelImplToJson(
  _$ActivityBadgeModelImpl instance,
) => <String, dynamic>{
  'badgecontent': instance.badgeContent,
  'badgestyle': instance.badgeStyle,
};
