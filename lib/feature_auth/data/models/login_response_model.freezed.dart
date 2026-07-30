// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) {
  return _LoginResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LoginResponseModel {
  /// Public web-service token (populated on success).
  String? get token => throw _privateConstructorUsedError;

  /// Optional private token for session re-establishment.
  String? get privatetoken => throw _privateConstructorUsedError;

  /// Human-readable error message (populated on failure).
  String? get error => throw _privateConstructorUsedError;

  /// Machine-readable error code, e.g. `invalidlogin` (populated on
  /// failure).
  String? get errorcode => throw _privateConstructorUsedError;

  /// Alternative human-readable message — some Moodle installs return
  /// `{"message":"..."}` without a top-level `error` field, particularly
  /// in older REST plugins. Captured here as a fallback so the repository
  /// can still surface a useful message to the user.
  String? get message => throw _privateConstructorUsedError;

  /// Stack trace (populated only in debug builds on failure).
  String? get stacktrace => throw _privateConstructorUsedError;

  /// Debug info (populated only in debug builds on failure).
  String? get debuginfo => throw _privateConstructorUsedError;

  /// Reproduction link (populated only in debug builds on failure).
  String? get reproductionlink => throw _privateConstructorUsedError;

  /// Serializes this LoginResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginResponseModelCopyWith<LoginResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseModelCopyWith<$Res> {
  factory $LoginResponseModelCopyWith(
    LoginResponseModel value,
    $Res Function(LoginResponseModel) then,
  ) = _$LoginResponseModelCopyWithImpl<$Res, LoginResponseModel>;
  @useResult
  $Res call({
    String? token,
    String? privatetoken,
    String? error,
    String? errorcode,
    String? message,
    String? stacktrace,
    String? debuginfo,
    String? reproductionlink,
  });
}

/// @nodoc
class _$LoginResponseModelCopyWithImpl<$Res, $Val extends LoginResponseModel>
    implements $LoginResponseModelCopyWith<$Res> {
  _$LoginResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? privatetoken = freezed,
    Object? error = freezed,
    Object? errorcode = freezed,
    Object? message = freezed,
    Object? stacktrace = freezed,
    Object? debuginfo = freezed,
    Object? reproductionlink = freezed,
  }) {
    return _then(
      _value.copyWith(
            token: freezed == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String?,
            privatetoken: freezed == privatetoken
                ? _value.privatetoken
                : privatetoken // ignore: cast_nullable_to_non_nullable
                      as String?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorcode: freezed == errorcode
                ? _value.errorcode
                : errorcode // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            stacktrace: freezed == stacktrace
                ? _value.stacktrace
                : stacktrace // ignore: cast_nullable_to_non_nullable
                      as String?,
            debuginfo: freezed == debuginfo
                ? _value.debuginfo
                : debuginfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            reproductionlink: freezed == reproductionlink
                ? _value.reproductionlink
                : reproductionlink // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginResponseModelImplCopyWith<$Res>
    implements $LoginResponseModelCopyWith<$Res> {
  factory _$$LoginResponseModelImplCopyWith(
    _$LoginResponseModelImpl value,
    $Res Function(_$LoginResponseModelImpl) then,
  ) = __$$LoginResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? token,
    String? privatetoken,
    String? error,
    String? errorcode,
    String? message,
    String? stacktrace,
    String? debuginfo,
    String? reproductionlink,
  });
}

/// @nodoc
class __$$LoginResponseModelImplCopyWithImpl<$Res>
    extends _$LoginResponseModelCopyWithImpl<$Res, _$LoginResponseModelImpl>
    implements _$$LoginResponseModelImplCopyWith<$Res> {
  __$$LoginResponseModelImplCopyWithImpl(
    _$LoginResponseModelImpl _value,
    $Res Function(_$LoginResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = freezed,
    Object? privatetoken = freezed,
    Object? error = freezed,
    Object? errorcode = freezed,
    Object? message = freezed,
    Object? stacktrace = freezed,
    Object? debuginfo = freezed,
    Object? reproductionlink = freezed,
  }) {
    return _then(
      _$LoginResponseModelImpl(
        token: freezed == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String?,
        privatetoken: freezed == privatetoken
            ? _value.privatetoken
            : privatetoken // ignore: cast_nullable_to_non_nullable
                  as String?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorcode: freezed == errorcode
            ? _value.errorcode
            : errorcode // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        stacktrace: freezed == stacktrace
            ? _value.stacktrace
            : stacktrace // ignore: cast_nullable_to_non_nullable
                  as String?,
        debuginfo: freezed == debuginfo
            ? _value.debuginfo
            : debuginfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        reproductionlink: freezed == reproductionlink
            ? _value.reproductionlink
            : reproductionlink // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseModelImpl implements _LoginResponseModel {
  const _$LoginResponseModelImpl({
    this.token,
    this.privatetoken,
    this.error,
    this.errorcode,
    this.message,
    this.stacktrace,
    this.debuginfo,
    this.reproductionlink,
  });

  factory _$LoginResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseModelImplFromJson(json);

  /// Public web-service token (populated on success).
  @override
  final String? token;

  /// Optional private token for session re-establishment.
  @override
  final String? privatetoken;

  /// Human-readable error message (populated on failure).
  @override
  final String? error;

  /// Machine-readable error code, e.g. `invalidlogin` (populated on
  /// failure).
  @override
  final String? errorcode;

  /// Alternative human-readable message — some Moodle installs return
  /// `{"message":"..."}` without a top-level `error` field, particularly
  /// in older REST plugins. Captured here as a fallback so the repository
  /// can still surface a useful message to the user.
  @override
  final String? message;

  /// Stack trace (populated only in debug builds on failure).
  @override
  final String? stacktrace;

  /// Debug info (populated only in debug builds on failure).
  @override
  final String? debuginfo;

  /// Reproduction link (populated only in debug builds on failure).
  @override
  final String? reproductionlink;

  @override
  String toString() {
    return 'LoginResponseModel(token: $token, privatetoken: $privatetoken, error: $error, errorcode: $errorcode, message: $message, stacktrace: $stacktrace, debuginfo: $debuginfo, reproductionlink: $reproductionlink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseModelImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.privatetoken, privatetoken) ||
                other.privatetoken == privatetoken) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.errorcode, errorcode) ||
                other.errorcode == errorcode) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stacktrace, stacktrace) ||
                other.stacktrace == stacktrace) &&
            (identical(other.debuginfo, debuginfo) ||
                other.debuginfo == debuginfo) &&
            (identical(other.reproductionlink, reproductionlink) ||
                other.reproductionlink == reproductionlink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    token,
    privatetoken,
    error,
    errorcode,
    message,
    stacktrace,
    debuginfo,
    reproductionlink,
  );

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseModelImplCopyWith<_$LoginResponseModelImpl> get copyWith =>
      __$$LoginResponseModelImplCopyWithImpl<_$LoginResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseModelImplToJson(this);
  }
}

abstract class _LoginResponseModel implements LoginResponseModel {
  const factory _LoginResponseModel({
    final String? token,
    final String? privatetoken,
    final String? error,
    final String? errorcode,
    final String? message,
    final String? stacktrace,
    final String? debuginfo,
    final String? reproductionlink,
  }) = _$LoginResponseModelImpl;

  factory _LoginResponseModel.fromJson(Map<String, dynamic> json) =
      _$LoginResponseModelImpl.fromJson;

  /// Public web-service token (populated on success).
  @override
  String? get token;

  /// Optional private token for session re-establishment.
  @override
  String? get privatetoken;

  /// Human-readable error message (populated on failure).
  @override
  String? get error;

  /// Machine-readable error code, e.g. `invalidlogin` (populated on
  /// failure).
  @override
  String? get errorcode;

  /// Alternative human-readable message — some Moodle installs return
  /// `{"message":"..."}` without a top-level `error` field, particularly
  /// in older REST plugins. Captured here as a fallback so the repository
  /// can still surface a useful message to the user.
  @override
  String? get message;

  /// Stack trace (populated only in debug builds on failure).
  @override
  String? get stacktrace;

  /// Debug info (populated only in debug builds on failure).
  @override
  String? get debuginfo;

  /// Reproduction link (populated only in debug builds on failure).
  @override
  String? get reproductionlink;

  /// Create a copy of LoginResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResponseModelImplCopyWith<_$LoginResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
