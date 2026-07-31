// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_content_file_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseContentFileModel _$CourseContentFileModelFromJson(
  Map<String, dynamic> json,
) {
  return _CourseContentFileModel.fromJson(json);
}

/// @nodoc
mixin _$CourseContentFileModel {
  /// Original filename as Moodle stores it.
  @JsonKey(name: 'filename')
  String get filename => throw _privateConstructorUsedError;

  /// Direct URL to the file (requires the requesting user's wstoken).
  @JsonKey(name: 'fileurl')
  String? get fileurl => throw _privateConstructorUsedError;

  /// MIME type (e.g. application/pdf, video/mp4).
  @JsonKey(name: 'mimetype')
  String? get mimetype => throw _privateConstructorUsedError;

  /// File size in bytes.
  @JsonKey(name: 'filesize')
  int get filesize => throw _privateConstructorUsedError;

  /// Moodle-internal filepath component (usually `/`).
  @JsonKey(name: 'filepath')
  String get filepath => throw _privateConstructorUsedError;

  /// When the file was uploaded (Unix seconds).
  @JsonKey(name: 'timecreated')
  int? get timecreated => throw _privateConstructorUsedError;

  /// When the file was last modified (Unix seconds).
  @JsonKey(name: 'timemodified')
  int? get timemodified => throw _privateConstructorUsedError;

  /// Serializes this CourseContentFileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseContentFileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseContentFileModelCopyWith<CourseContentFileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseContentFileModelCopyWith<$Res> {
  factory $CourseContentFileModelCopyWith(
    CourseContentFileModel value,
    $Res Function(CourseContentFileModel) then,
  ) = _$CourseContentFileModelCopyWithImpl<$Res, CourseContentFileModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'filename') String filename,
    @JsonKey(name: 'fileurl') String? fileurl,
    @JsonKey(name: 'mimetype') String? mimetype,
    @JsonKey(name: 'filesize') int filesize,
    @JsonKey(name: 'filepath') String filepath,
    @JsonKey(name: 'timecreated') int? timecreated,
    @JsonKey(name: 'timemodified') int? timemodified,
  });
}

/// @nodoc
class _$CourseContentFileModelCopyWithImpl<
  $Res,
  $Val extends CourseContentFileModel
>
    implements $CourseContentFileModelCopyWith<$Res> {
  _$CourseContentFileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseContentFileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? fileurl = freezed,
    Object? mimetype = freezed,
    Object? filesize = null,
    Object? filepath = null,
    Object? timecreated = freezed,
    Object? timemodified = freezed,
  }) {
    return _then(
      _value.copyWith(
            filename: null == filename
                ? _value.filename
                : filename // ignore: cast_nullable_to_non_nullable
                      as String,
            fileurl: freezed == fileurl
                ? _value.fileurl
                : fileurl // ignore: cast_nullable_to_non_nullable
                      as String?,
            mimetype: freezed == mimetype
                ? _value.mimetype
                : mimetype // ignore: cast_nullable_to_non_nullable
                      as String?,
            filesize: null == filesize
                ? _value.filesize
                : filesize // ignore: cast_nullable_to_non_nullable
                      as int,
            filepath: null == filepath
                ? _value.filepath
                : filepath // ignore: cast_nullable_to_non_nullable
                      as String,
            timecreated: freezed == timecreated
                ? _value.timecreated
                : timecreated // ignore: cast_nullable_to_non_nullable
                      as int?,
            timemodified: freezed == timemodified
                ? _value.timemodified
                : timemodified // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseContentFileModelImplCopyWith<$Res>
    implements $CourseContentFileModelCopyWith<$Res> {
  factory _$$CourseContentFileModelImplCopyWith(
    _$CourseContentFileModelImpl value,
    $Res Function(_$CourseContentFileModelImpl) then,
  ) = __$$CourseContentFileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'filename') String filename,
    @JsonKey(name: 'fileurl') String? fileurl,
    @JsonKey(name: 'mimetype') String? mimetype,
    @JsonKey(name: 'filesize') int filesize,
    @JsonKey(name: 'filepath') String filepath,
    @JsonKey(name: 'timecreated') int? timecreated,
    @JsonKey(name: 'timemodified') int? timemodified,
  });
}

/// @nodoc
class __$$CourseContentFileModelImplCopyWithImpl<$Res>
    extends
        _$CourseContentFileModelCopyWithImpl<$Res, _$CourseContentFileModelImpl>
    implements _$$CourseContentFileModelImplCopyWith<$Res> {
  __$$CourseContentFileModelImplCopyWithImpl(
    _$CourseContentFileModelImpl _value,
    $Res Function(_$CourseContentFileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseContentFileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? fileurl = freezed,
    Object? mimetype = freezed,
    Object? filesize = null,
    Object? filepath = null,
    Object? timecreated = freezed,
    Object? timemodified = freezed,
  }) {
    return _then(
      _$CourseContentFileModelImpl(
        filename: null == filename
            ? _value.filename
            : filename // ignore: cast_nullable_to_non_nullable
                  as String,
        fileurl: freezed == fileurl
            ? _value.fileurl
            : fileurl // ignore: cast_nullable_to_non_nullable
                  as String?,
        mimetype: freezed == mimetype
            ? _value.mimetype
            : mimetype // ignore: cast_nullable_to_non_nullable
                  as String?,
        filesize: null == filesize
            ? _value.filesize
            : filesize // ignore: cast_nullable_to_non_nullable
                  as int,
        filepath: null == filepath
            ? _value.filepath
            : filepath // ignore: cast_nullable_to_non_nullable
                  as String,
        timecreated: freezed == timecreated
            ? _value.timecreated
            : timecreated // ignore: cast_nullable_to_non_nullable
                  as int?,
        timemodified: freezed == timemodified
            ? _value.timemodified
            : timemodified // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseContentFileModelImpl implements _CourseContentFileModel {
  const _$CourseContentFileModelImpl({
    @JsonKey(name: 'filename') this.filename = '',
    @JsonKey(name: 'fileurl') this.fileurl,
    @JsonKey(name: 'mimetype') this.mimetype,
    @JsonKey(name: 'filesize') this.filesize = 0,
    @JsonKey(name: 'filepath') this.filepath = '/',
    @JsonKey(name: 'timecreated') this.timecreated,
    @JsonKey(name: 'timemodified') this.timemodified,
  });

  factory _$CourseContentFileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseContentFileModelImplFromJson(json);

  /// Original filename as Moodle stores it.
  @override
  @JsonKey(name: 'filename')
  final String filename;

  /// Direct URL to the file (requires the requesting user's wstoken).
  @override
  @JsonKey(name: 'fileurl')
  final String? fileurl;

  /// MIME type (e.g. application/pdf, video/mp4).
  @override
  @JsonKey(name: 'mimetype')
  final String? mimetype;

  /// File size in bytes.
  @override
  @JsonKey(name: 'filesize')
  final int filesize;

  /// Moodle-internal filepath component (usually `/`).
  @override
  @JsonKey(name: 'filepath')
  final String filepath;

  /// When the file was uploaded (Unix seconds).
  @override
  @JsonKey(name: 'timecreated')
  final int? timecreated;

  /// When the file was last modified (Unix seconds).
  @override
  @JsonKey(name: 'timemodified')
  final int? timemodified;

  @override
  String toString() {
    return 'CourseContentFileModel(filename: $filename, fileurl: $fileurl, mimetype: $mimetype, filesize: $filesize, filepath: $filepath, timecreated: $timecreated, timemodified: $timemodified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseContentFileModelImpl &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.fileurl, fileurl) || other.fileurl == fileurl) &&
            (identical(other.mimetype, mimetype) ||
                other.mimetype == mimetype) &&
            (identical(other.filesize, filesize) ||
                other.filesize == filesize) &&
            (identical(other.filepath, filepath) ||
                other.filepath == filepath) &&
            (identical(other.timecreated, timecreated) ||
                other.timecreated == timecreated) &&
            (identical(other.timemodified, timemodified) ||
                other.timemodified == timemodified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    filename,
    fileurl,
    mimetype,
    filesize,
    filepath,
    timecreated,
    timemodified,
  );

  /// Create a copy of CourseContentFileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseContentFileModelImplCopyWith<_$CourseContentFileModelImpl>
  get copyWith =>
      __$$CourseContentFileModelImplCopyWithImpl<_$CourseContentFileModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseContentFileModelImplToJson(this);
  }
}

abstract class _CourseContentFileModel implements CourseContentFileModel {
  const factory _CourseContentFileModel({
    @JsonKey(name: 'filename') final String filename,
    @JsonKey(name: 'fileurl') final String? fileurl,
    @JsonKey(name: 'mimetype') final String? mimetype,
    @JsonKey(name: 'filesize') final int filesize,
    @JsonKey(name: 'filepath') final String filepath,
    @JsonKey(name: 'timecreated') final int? timecreated,
    @JsonKey(name: 'timemodified') final int? timemodified,
  }) = _$CourseContentFileModelImpl;

  factory _CourseContentFileModel.fromJson(Map<String, dynamic> json) =
      _$CourseContentFileModelImpl.fromJson;

  /// Original filename as Moodle stores it.
  @override
  @JsonKey(name: 'filename')
  String get filename;

  /// Direct URL to the file (requires the requesting user's wstoken).
  @override
  @JsonKey(name: 'fileurl')
  String? get fileurl;

  /// MIME type (e.g. application/pdf, video/mp4).
  @override
  @JsonKey(name: 'mimetype')
  String? get mimetype;

  /// File size in bytes.
  @override
  @JsonKey(name: 'filesize')
  int get filesize;

  /// Moodle-internal filepath component (usually `/`).
  @override
  @JsonKey(name: 'filepath')
  String get filepath;

  /// When the file was uploaded (Unix seconds).
  @override
  @JsonKey(name: 'timecreated')
  int? get timecreated;

  /// When the file was last modified (Unix seconds).
  @override
  @JsonKey(name: 'timemodified')
  int? get timemodified;

  /// Create a copy of CourseContentFileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseContentFileModelImplCopyWith<_$CourseContentFileModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
