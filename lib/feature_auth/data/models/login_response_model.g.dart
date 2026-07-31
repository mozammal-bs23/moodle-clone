// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseModelImpl _$$LoginResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$LoginResponseModelImpl(
  token: json['token'] as String?,
  privatetoken: json['privatetoken'] as String?,
  error: json['error'] as String?,
  errorcode: json['errorcode'] as String?,
  message: json['message'] as String?,
  stacktrace: json['stacktrace'] as String?,
  debuginfo: json['debuginfo'] as String?,
  reproductionlink: json['reproductionlink'] as String?,
);

Map<String, dynamic> _$$LoginResponseModelImplToJson(
  _$LoginResponseModelImpl instance,
) => <String, dynamic>{
  'token': instance.token,
  'privatetoken': instance.privatetoken,
  'error': instance.error,
  'errorcode': instance.errorcode,
  'message': instance.message,
  'stacktrace': instance.stacktrace,
  'debuginfo': instance.debuginfo,
  'reproductionlink': instance.reproductionlink,
};
