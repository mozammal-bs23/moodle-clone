// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_content_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseContentFileModelImpl _$$CourseContentFileModelImplFromJson(
  Map<String, dynamic> json,
) => _$CourseContentFileModelImpl(
  filename: json['filename'] as String? ?? '',
  fileurl: json['fileurl'] as String?,
  mimetype: json['mimetype'] as String?,
  filesize: (json['filesize'] as num?)?.toInt() ?? 0,
  filepath: json['filepath'] as String? ?? '/',
  timecreated: (json['timecreated'] as num?)?.toInt(),
  timemodified: (json['timemodified'] as num?)?.toInt(),
);

Map<String, dynamic> _$$CourseContentFileModelImplToJson(
  _$CourseContentFileModelImpl instance,
) => <String, dynamic>{
  'filename': instance.filename,
  'fileurl': instance.fileurl,
  'mimetype': instance.mimetype,
  'filesize': instance.filesize,
  'filepath': instance.filepath,
  'timecreated': instance.timecreated,
  'timemodified': instance.timemodified,
};
