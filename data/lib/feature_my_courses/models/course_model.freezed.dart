// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) {
  return _CourseModel.fromJson(json);
}

/// @nodoc
mixin _$CourseModel {
  /// Numeric id (parsed tolerantly — see [IdParser]).
  int get id => throw _privateConstructorUsedError;

  /// Human-readable course name.
  @JsonKey(name: 'fullname')
  String get fullname => throw _privateConstructorUsedError;

  /// Short course code.
  @JsonKey(name: 'shortname')
  String get shortname => throw _privateConstructorUsedError;

  /// Display name (may equal fullname).
  @JsonKey(name: 'displayname')
  String get displayname => throw _privateConstructorUsedError;

  /// HTML-stripped plain-text summary.
  @JsonKey(name: 'summary')
  String get summary => throw _privateConstructorUsedError;

  /// Category id. Moodle's `core_enrol_get_users_courses` returns this
  /// as the field name `category` (not `categoryid` — that's the
  /// name used by `core_course_get_courses`). We map both shapes for
  /// robustness across endpoints.
  @JsonKey(name: 'category', readValue: _readCategoryId)
  int get categoryId => throw _privateConstructorUsedError;

  /// 0–100 progress percentage.
  @JsonKey(name: 'progress')
  double? get progress => throw _privateConstructorUsedError;

  /// `overviewfiles` flattened to a single image URL.
  @JsonKey(name: 'overviewfiles')
  List<OverviewFile> get overviewfiles => throw _privateConstructorUsedError;

  /// Course image URL (Moodle 4.x).
  @JsonKey(name: 'courseimage')
  String? get courseimage => throw _privateConstructorUsedError;

  /// Visibility (0/1).
  @JsonKey(name: 'visible')
  int get visible => throw _privateConstructorUsedError;

  /// Start date as milliseconds since epoch.
  @JsonKey(name: 'startdate')
  int? get startdate => throw _privateConstructorUsedError;

  /// End date as milliseconds since epoch.
  @JsonKey(name: 'enddate')
  int? get enddate => throw _privateConstructorUsedError;

  /// Serializes this CourseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseModelCopyWith<CourseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseModelCopyWith<$Res> {
  factory $CourseModelCopyWith(
    CourseModel value,
    $Res Function(CourseModel) then,
  ) = _$CourseModelCopyWithImpl<$Res, CourseModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'fullname') String fullname,
    @JsonKey(name: 'shortname') String shortname,
    @JsonKey(name: 'displayname') String displayname,
    @JsonKey(name: 'summary') String summary,
    @JsonKey(name: 'category', readValue: _readCategoryId) int categoryId,
    @JsonKey(name: 'progress') double? progress,
    @JsonKey(name: 'overviewfiles') List<OverviewFile> overviewfiles,
    @JsonKey(name: 'courseimage') String? courseimage,
    @JsonKey(name: 'visible') int visible,
    @JsonKey(name: 'startdate') int? startdate,
    @JsonKey(name: 'enddate') int? enddate,
  });
}

/// @nodoc
class _$CourseModelCopyWithImpl<$Res, $Val extends CourseModel>
    implements $CourseModelCopyWith<$Res> {
  _$CourseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullname = null,
    Object? shortname = null,
    Object? displayname = null,
    Object? summary = null,
    Object? categoryId = null,
    Object? progress = freezed,
    Object? overviewfiles = null,
    Object? courseimage = freezed,
    Object? visible = null,
    Object? startdate = freezed,
    Object? enddate = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            fullname: null == fullname
                ? _value.fullname
                : fullname // ignore: cast_nullable_to_non_nullable
                      as String,
            shortname: null == shortname
                ? _value.shortname
                : shortname // ignore: cast_nullable_to_non_nullable
                      as String,
            displayname: null == displayname
                ? _value.displayname
                : displayname // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            progress: freezed == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double?,
            overviewfiles: null == overviewfiles
                ? _value.overviewfiles
                : overviewfiles // ignore: cast_nullable_to_non_nullable
                      as List<OverviewFile>,
            courseimage: freezed == courseimage
                ? _value.courseimage
                : courseimage // ignore: cast_nullable_to_non_nullable
                      as String?,
            visible: null == visible
                ? _value.visible
                : visible // ignore: cast_nullable_to_non_nullable
                      as int,
            startdate: freezed == startdate
                ? _value.startdate
                : startdate // ignore: cast_nullable_to_non_nullable
                      as int?,
            enddate: freezed == enddate
                ? _value.enddate
                : enddate // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseModelImplCopyWith<$Res>
    implements $CourseModelCopyWith<$Res> {
  factory _$$CourseModelImplCopyWith(
    _$CourseModelImpl value,
    $Res Function(_$CourseModelImpl) then,
  ) = __$$CourseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'fullname') String fullname,
    @JsonKey(name: 'shortname') String shortname,
    @JsonKey(name: 'displayname') String displayname,
    @JsonKey(name: 'summary') String summary,
    @JsonKey(name: 'category', readValue: _readCategoryId) int categoryId,
    @JsonKey(name: 'progress') double? progress,
    @JsonKey(name: 'overviewfiles') List<OverviewFile> overviewfiles,
    @JsonKey(name: 'courseimage') String? courseimage,
    @JsonKey(name: 'visible') int visible,
    @JsonKey(name: 'startdate') int? startdate,
    @JsonKey(name: 'enddate') int? enddate,
  });
}

/// @nodoc
class __$$CourseModelImplCopyWithImpl<$Res>
    extends _$CourseModelCopyWithImpl<$Res, _$CourseModelImpl>
    implements _$$CourseModelImplCopyWith<$Res> {
  __$$CourseModelImplCopyWithImpl(
    _$CourseModelImpl _value,
    $Res Function(_$CourseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullname = null,
    Object? shortname = null,
    Object? displayname = null,
    Object? summary = null,
    Object? categoryId = null,
    Object? progress = freezed,
    Object? overviewfiles = null,
    Object? courseimage = freezed,
    Object? visible = null,
    Object? startdate = freezed,
    Object? enddate = freezed,
  }) {
    return _then(
      _$CourseModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        fullname: null == fullname
            ? _value.fullname
            : fullname // ignore: cast_nullable_to_non_nullable
                  as String,
        shortname: null == shortname
            ? _value.shortname
            : shortname // ignore: cast_nullable_to_non_nullable
                  as String,
        displayname: null == displayname
            ? _value.displayname
            : displayname // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        progress: freezed == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double?,
        overviewfiles: null == overviewfiles
            ? _value._overviewfiles
            : overviewfiles // ignore: cast_nullable_to_non_nullable
                  as List<OverviewFile>,
        courseimage: freezed == courseimage
            ? _value.courseimage
            : courseimage // ignore: cast_nullable_to_non_nullable
                  as String?,
        visible: null == visible
            ? _value.visible
            : visible // ignore: cast_nullable_to_non_nullable
                  as int,
        startdate: freezed == startdate
            ? _value.startdate
            : startdate // ignore: cast_nullable_to_non_nullable
                  as int?,
        enddate: freezed == enddate
            ? _value.enddate
            : enddate // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseModelImpl implements _CourseModel {
  const _$CourseModelImpl({
    required this.id,
    @JsonKey(name: 'fullname') required this.fullname,
    @JsonKey(name: 'shortname') required this.shortname,
    @JsonKey(name: 'displayname') this.displayname = '',
    @JsonKey(name: 'summary') this.summary = '',
    @JsonKey(name: 'category', readValue: _readCategoryId) this.categoryId = 0,
    @JsonKey(name: 'progress') this.progress,
    @JsonKey(name: 'overviewfiles')
    final List<OverviewFile> overviewfiles = const <OverviewFile>[],
    @JsonKey(name: 'courseimage') this.courseimage,
    @JsonKey(name: 'visible') this.visible = 1,
    @JsonKey(name: 'startdate') this.startdate,
    @JsonKey(name: 'enddate') this.enddate,
  }) : _overviewfiles = overviewfiles;

  factory _$CourseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseModelImplFromJson(json);

  /// Numeric id (parsed tolerantly — see [IdParser]).
  @override
  final int id;

  /// Human-readable course name.
  @override
  @JsonKey(name: 'fullname')
  final String fullname;

  /// Short course code.
  @override
  @JsonKey(name: 'shortname')
  final String shortname;

  /// Display name (may equal fullname).
  @override
  @JsonKey(name: 'displayname')
  final String displayname;

  /// HTML-stripped plain-text summary.
  @override
  @JsonKey(name: 'summary')
  final String summary;

  /// Category id. Moodle's `core_enrol_get_users_courses` returns this
  /// as the field name `category` (not `categoryid` — that's the
  /// name used by `core_course_get_courses`). We map both shapes for
  /// robustness across endpoints.
  @override
  @JsonKey(name: 'category', readValue: _readCategoryId)
  final int categoryId;

  /// 0–100 progress percentage.
  @override
  @JsonKey(name: 'progress')
  final double? progress;

  /// `overviewfiles` flattened to a single image URL.
  final List<OverviewFile> _overviewfiles;

  /// `overviewfiles` flattened to a single image URL.
  @override
  @JsonKey(name: 'overviewfiles')
  List<OverviewFile> get overviewfiles {
    if (_overviewfiles is EqualUnmodifiableListView) return _overviewfiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_overviewfiles);
  }

  /// Course image URL (Moodle 4.x).
  @override
  @JsonKey(name: 'courseimage')
  final String? courseimage;

  /// Visibility (0/1).
  @override
  @JsonKey(name: 'visible')
  final int visible;

  /// Start date as milliseconds since epoch.
  @override
  @JsonKey(name: 'startdate')
  final int? startdate;

  /// End date as milliseconds since epoch.
  @override
  @JsonKey(name: 'enddate')
  final int? enddate;

  @override
  String toString() {
    return 'CourseModel(id: $id, fullname: $fullname, shortname: $shortname, displayname: $displayname, summary: $summary, categoryId: $categoryId, progress: $progress, overviewfiles: $overviewfiles, courseimage: $courseimage, visible: $visible, startdate: $startdate, enddate: $enddate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullname, fullname) ||
                other.fullname == fullname) &&
            (identical(other.shortname, shortname) ||
                other.shortname == shortname) &&
            (identical(other.displayname, displayname) ||
                other.displayname == displayname) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality().equals(
              other._overviewfiles,
              _overviewfiles,
            ) &&
            (identical(other.courseimage, courseimage) ||
                other.courseimage == courseimage) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.startdate, startdate) ||
                other.startdate == startdate) &&
            (identical(other.enddate, enddate) || other.enddate == enddate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullname,
    shortname,
    displayname,
    summary,
    categoryId,
    progress,
    const DeepCollectionEquality().hash(_overviewfiles),
    courseimage,
    visible,
    startdate,
    enddate,
  );

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseModelImplCopyWith<_$CourseModelImpl> get copyWith =>
      __$$CourseModelImplCopyWithImpl<_$CourseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseModelImplToJson(this);
  }
}

abstract class _CourseModel implements CourseModel {
  const factory _CourseModel({
    required final int id,
    @JsonKey(name: 'fullname') required final String fullname,
    @JsonKey(name: 'shortname') required final String shortname,
    @JsonKey(name: 'displayname') final String displayname,
    @JsonKey(name: 'summary') final String summary,
    @JsonKey(name: 'category', readValue: _readCategoryId) final int categoryId,
    @JsonKey(name: 'progress') final double? progress,
    @JsonKey(name: 'overviewfiles') final List<OverviewFile> overviewfiles,
    @JsonKey(name: 'courseimage') final String? courseimage,
    @JsonKey(name: 'visible') final int visible,
    @JsonKey(name: 'startdate') final int? startdate,
    @JsonKey(name: 'enddate') final int? enddate,
  }) = _$CourseModelImpl;

  factory _CourseModel.fromJson(Map<String, dynamic> json) =
      _$CourseModelImpl.fromJson;

  /// Numeric id (parsed tolerantly — see [IdParser]).
  @override
  int get id;

  /// Human-readable course name.
  @override
  @JsonKey(name: 'fullname')
  String get fullname;

  /// Short course code.
  @override
  @JsonKey(name: 'shortname')
  String get shortname;

  /// Display name (may equal fullname).
  @override
  @JsonKey(name: 'displayname')
  String get displayname;

  /// HTML-stripped plain-text summary.
  @override
  @JsonKey(name: 'summary')
  String get summary;

  /// Category id. Moodle's `core_enrol_get_users_courses` returns this
  /// as the field name `category` (not `categoryid` — that's the
  /// name used by `core_course_get_courses`). We map both shapes for
  /// robustness across endpoints.
  @override
  @JsonKey(name: 'category', readValue: _readCategoryId)
  int get categoryId;

  /// 0–100 progress percentage.
  @override
  @JsonKey(name: 'progress')
  double? get progress;

  /// `overviewfiles` flattened to a single image URL.
  @override
  @JsonKey(name: 'overviewfiles')
  List<OverviewFile> get overviewfiles;

  /// Course image URL (Moodle 4.x).
  @override
  @JsonKey(name: 'courseimage')
  String? get courseimage;

  /// Visibility (0/1).
  @override
  @JsonKey(name: 'visible')
  int get visible;

  /// Start date as milliseconds since epoch.
  @override
  @JsonKey(name: 'startdate')
  int? get startdate;

  /// End date as milliseconds since epoch.
  @override
  @JsonKey(name: 'enddate')
  int? get enddate;

  /// Create a copy of CourseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseModelImplCopyWith<_$CourseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OverviewFile _$OverviewFileFromJson(Map<String, dynamic> json) {
  return _OverviewFile.fromJson(json);
}

/// @nodoc
mixin _$OverviewFile {
  /// Direct URL to the file.
  @JsonKey(name: 'fileurl')
  String? get fileurl => throw _privateConstructorUsedError;

  /// Serializes this OverviewFile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverviewFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverviewFileCopyWith<OverviewFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverviewFileCopyWith<$Res> {
  factory $OverviewFileCopyWith(
    OverviewFile value,
    $Res Function(OverviewFile) then,
  ) = _$OverviewFileCopyWithImpl<$Res, OverviewFile>;
  @useResult
  $Res call({@JsonKey(name: 'fileurl') String? fileurl});
}

/// @nodoc
class _$OverviewFileCopyWithImpl<$Res, $Val extends OverviewFile>
    implements $OverviewFileCopyWith<$Res> {
  _$OverviewFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverviewFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fileurl = freezed}) {
    return _then(
      _value.copyWith(
            fileurl: freezed == fileurl
                ? _value.fileurl
                : fileurl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OverviewFileImplCopyWith<$Res>
    implements $OverviewFileCopyWith<$Res> {
  factory _$$OverviewFileImplCopyWith(
    _$OverviewFileImpl value,
    $Res Function(_$OverviewFileImpl) then,
  ) = __$$OverviewFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'fileurl') String? fileurl});
}

/// @nodoc
class __$$OverviewFileImplCopyWithImpl<$Res>
    extends _$OverviewFileCopyWithImpl<$Res, _$OverviewFileImpl>
    implements _$$OverviewFileImplCopyWith<$Res> {
  __$$OverviewFileImplCopyWithImpl(
    _$OverviewFileImpl _value,
    $Res Function(_$OverviewFileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OverviewFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? fileurl = freezed}) {
    return _then(
      _$OverviewFileImpl(
        fileurl: freezed == fileurl
            ? _value.fileurl
            : fileurl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OverviewFileImpl implements _OverviewFile {
  const _$OverviewFileImpl({@JsonKey(name: 'fileurl') this.fileurl});

  factory _$OverviewFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverviewFileImplFromJson(json);

  /// Direct URL to the file.
  @override
  @JsonKey(name: 'fileurl')
  final String? fileurl;

  @override
  String toString() {
    return 'OverviewFile(fileurl: $fileurl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverviewFileImpl &&
            (identical(other.fileurl, fileurl) || other.fileurl == fileurl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fileurl);

  /// Create a copy of OverviewFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverviewFileImplCopyWith<_$OverviewFileImpl> get copyWith =>
      __$$OverviewFileImplCopyWithImpl<_$OverviewFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverviewFileImplToJson(this);
  }
}

abstract class _OverviewFile implements OverviewFile {
  const factory _OverviewFile({
    @JsonKey(name: 'fileurl') final String? fileurl,
  }) = _$OverviewFileImpl;

  factory _OverviewFile.fromJson(Map<String, dynamic> json) =
      _$OverviewFileImpl.fromJson;

  /// Direct URL to the file.
  @override
  @JsonKey(name: 'fileurl')
  String? get fileurl;

  /// Create a copy of OverviewFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverviewFileImplCopyWith<_$OverviewFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
