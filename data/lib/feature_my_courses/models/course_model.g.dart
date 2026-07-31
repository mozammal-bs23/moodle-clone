// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseModelImpl _$$CourseModelImplFromJson(Map<String, dynamic> json) =>
    _$CourseModelImpl(
      id: (json['id'] as num).toInt(),
      fullname: json['fullname'] as String,
      shortname: json['shortname'] as String,
      displayname: json['displayname'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      categoryId: (_readCategoryId(json, 'category') as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble(),
      overviewfiles:
          (json['overviewfiles'] as List<dynamic>?)
              ?.map((e) => OverviewFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <OverviewFile>[],
      courseimage: json['courseimage'] as String?,
      visible: (json['visible'] as num?)?.toInt() ?? 1,
      startdate: (json['startdate'] as num?)?.toInt(),
      enddate: (json['enddate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CourseModelImplToJson(_$CourseModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'shortname': instance.shortname,
      'displayname': instance.displayname,
      'summary': instance.summary,
      'category': instance.categoryId,
      'progress': instance.progress,
      'overviewfiles': instance.overviewfiles,
      'courseimage': instance.courseimage,
      'visible': instance.visible,
      'startdate': instance.startdate,
      'enddate': instance.enddate,
    };

_$OverviewFileImpl _$$OverviewFileImplFromJson(Map<String, dynamic> json) =>
    _$OverviewFileImpl(fileurl: json['fileurl'] as String?);

Map<String, dynamic> _$$OverviewFileImplToJson(_$OverviewFileImpl instance) =>
    <String, dynamic>{'fileurl': instance.fileurl};
