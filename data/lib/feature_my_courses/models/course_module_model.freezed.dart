// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_module_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseModuleModel _$CourseModuleModelFromJson(Map<String, dynamic> json) {
  return _CourseModuleModel.fromJson(json);
}

/// @nodoc
mixin _$CourseModuleModel {
  /// Moodle course-module id.
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;

  /// Display name (e.g. "Test Assignment").
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;

  /// Module type identifier (e.g. assign, quiz, page).
  @JsonKey(name: 'modname')
  String get modname => throw _privateConstructorUsedError;

  /// Activity instance id.
  @JsonKey(name: 'instance')
  int get instance => throw _privateConstructorUsedError;

  /// Optional launch URL for the activity.
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;

  /// Module-specific icon URL provided by the Moodle theme
  /// (e.g. `theme/image.php/mb2nl/forum/.../monologo`). Surfaced to
  /// the UI so each module renders the exact icon the site
  /// configured instead of relying on a hard-coded glyph map.
  @JsonKey(name: 'modicon')
  String? get modicon => throw _privateConstructorUsedError;

  /// Optional activity badge (e.g. `{"badgecontent":"MP4"}` for file
  /// modules). The UI renders this verbatim as the file chip label —
  /// no client-side derivation from mimetype or filename.
  ///
  /// The Moodle API returns `[]` (empty array) for modules that don't
  /// supply a badge and `{...}` (object) for ones that do. We treat
  /// the array as "no badge" so the model stays nullable.
  @JsonKey(name: 'activitybadge', readValue: _readActivityBadge)
  ActivityBadgeModel? get activityBadge => throw _privateConstructorUsedError;

  /// Whether the module is visible (0/1).
  @JsonKey(name: 'visible')
  int get visible => throw _privateConstructorUsedError;

  /// Whether the current user can see the module (boolean in the
  /// live Moodle response — older docs show 0/1). Accept both shapes
  /// by keeping the model field nullable and normalising in
  /// [toEntity].
  @JsonKey(name: 'uservisible')
  bool? get userVisible => throw _privateConstructorUsedError;

  /// Files attached to this module. Always defaulted to `[]` so the
  /// UI doesn't have to null-check.
  @JsonKey(name: 'contents')
  List<CourseContentFileModel> get contents =>
      throw _privateConstructorUsedError;

  /// Per-event date labels and timestamps returned by Moodle.
  /// We pick the open/close values out of this in [toEntity].
  @JsonKey(name: 'dates')
  List<DateLabelModel> get dates => throw _privateConstructorUsedError;

  /// Completion state for the current user. Moodle returns `0` (not
  /// completed) or `1` (completed). We map to a nullable bool so the
  /// UI can decide what to render (or nothing at all when the course
  /// doesn't track completion).
  @JsonKey(name: 'completion')
  int? get completion => throw _privateConstructorUsedError;

  /// Serializes this CourseModuleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseModuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseModuleModelCopyWith<CourseModuleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseModuleModelCopyWith<$Res> {
  factory $CourseModuleModelCopyWith(
    CourseModuleModel value,
    $Res Function(CourseModuleModel) then,
  ) = _$CourseModuleModelCopyWithImpl<$Res, CourseModuleModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'modname') String modname,
    @JsonKey(name: 'instance') int instance,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'modicon') String? modicon,
    @JsonKey(name: 'activitybadge', readValue: _readActivityBadge)
    ActivityBadgeModel? activityBadge,
    @JsonKey(name: 'visible') int visible,
    @JsonKey(name: 'uservisible') bool? userVisible,
    @JsonKey(name: 'contents') List<CourseContentFileModel> contents,
    @JsonKey(name: 'dates') List<DateLabelModel> dates,
    @JsonKey(name: 'completion') int? completion,
  });

  $ActivityBadgeModelCopyWith<$Res>? get activityBadge;
}

/// @nodoc
class _$CourseModuleModelCopyWithImpl<$Res, $Val extends CourseModuleModel>
    implements $CourseModuleModelCopyWith<$Res> {
  _$CourseModuleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseModuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? modname = null,
    Object? instance = null,
    Object? url = freezed,
    Object? modicon = freezed,
    Object? activityBadge = freezed,
    Object? visible = null,
    Object? userVisible = freezed,
    Object? contents = null,
    Object? dates = null,
    Object? completion = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            modname: null == modname
                ? _value.modname
                : modname // ignore: cast_nullable_to_non_nullable
                      as String,
            instance: null == instance
                ? _value.instance
                : instance // ignore: cast_nullable_to_non_nullable
                      as int,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            modicon: freezed == modicon
                ? _value.modicon
                : modicon // ignore: cast_nullable_to_non_nullable
                      as String?,
            activityBadge: freezed == activityBadge
                ? _value.activityBadge
                : activityBadge // ignore: cast_nullable_to_non_nullable
                      as ActivityBadgeModel?,
            visible: null == visible
                ? _value.visible
                : visible // ignore: cast_nullable_to_non_nullable
                      as int,
            userVisible: freezed == userVisible
                ? _value.userVisible
                : userVisible // ignore: cast_nullable_to_non_nullable
                      as bool?,
            contents: null == contents
                ? _value.contents
                : contents // ignore: cast_nullable_to_non_nullable
                      as List<CourseContentFileModel>,
            dates: null == dates
                ? _value.dates
                : dates // ignore: cast_nullable_to_non_nullable
                      as List<DateLabelModel>,
            completion: freezed == completion
                ? _value.completion
                : completion // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of CourseModuleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActivityBadgeModelCopyWith<$Res>? get activityBadge {
    if (_value.activityBadge == null) {
      return null;
    }

    return $ActivityBadgeModelCopyWith<$Res>(_value.activityBadge!, (value) {
      return _then(_value.copyWith(activityBadge: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CourseModuleModelImplCopyWith<$Res>
    implements $CourseModuleModelCopyWith<$Res> {
  factory _$$CourseModuleModelImplCopyWith(
    _$CourseModuleModelImpl value,
    $Res Function(_$CourseModuleModelImpl) then,
  ) = __$$CourseModuleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'modname') String modname,
    @JsonKey(name: 'instance') int instance,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'modicon') String? modicon,
    @JsonKey(name: 'activitybadge', readValue: _readActivityBadge)
    ActivityBadgeModel? activityBadge,
    @JsonKey(name: 'visible') int visible,
    @JsonKey(name: 'uservisible') bool? userVisible,
    @JsonKey(name: 'contents') List<CourseContentFileModel> contents,
    @JsonKey(name: 'dates') List<DateLabelModel> dates,
    @JsonKey(name: 'completion') int? completion,
  });

  @override
  $ActivityBadgeModelCopyWith<$Res>? get activityBadge;
}

/// @nodoc
class __$$CourseModuleModelImplCopyWithImpl<$Res>
    extends _$CourseModuleModelCopyWithImpl<$Res, _$CourseModuleModelImpl>
    implements _$$CourseModuleModelImplCopyWith<$Res> {
  __$$CourseModuleModelImplCopyWithImpl(
    _$CourseModuleModelImpl _value,
    $Res Function(_$CourseModuleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseModuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? modname = null,
    Object? instance = null,
    Object? url = freezed,
    Object? modicon = freezed,
    Object? activityBadge = freezed,
    Object? visible = null,
    Object? userVisible = freezed,
    Object? contents = null,
    Object? dates = null,
    Object? completion = freezed,
  }) {
    return _then(
      _$CourseModuleModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        modname: null == modname
            ? _value.modname
            : modname // ignore: cast_nullable_to_non_nullable
                  as String,
        instance: null == instance
            ? _value.instance
            : instance // ignore: cast_nullable_to_non_nullable
                  as int,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        modicon: freezed == modicon
            ? _value.modicon
            : modicon // ignore: cast_nullable_to_non_nullable
                  as String?,
        activityBadge: freezed == activityBadge
            ? _value.activityBadge
            : activityBadge // ignore: cast_nullable_to_non_nullable
                  as ActivityBadgeModel?,
        visible: null == visible
            ? _value.visible
            : visible // ignore: cast_nullable_to_non_nullable
                  as int,
        userVisible: freezed == userVisible
            ? _value.userVisible
            : userVisible // ignore: cast_nullable_to_non_nullable
                  as bool?,
        contents: null == contents
            ? _value._contents
            : contents // ignore: cast_nullable_to_non_nullable
                  as List<CourseContentFileModel>,
        dates: null == dates
            ? _value._dates
            : dates // ignore: cast_nullable_to_non_nullable
                  as List<DateLabelModel>,
        completion: freezed == completion
            ? _value.completion
            : completion // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseModuleModelImpl implements _CourseModuleModel {
  const _$CourseModuleModelImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'modname') this.modname = '',
    @JsonKey(name: 'instance') this.instance = 0,
    @JsonKey(name: 'url') this.url,
    @JsonKey(name: 'modicon') this.modicon,
    @JsonKey(name: 'activitybadge', readValue: _readActivityBadge)
    this.activityBadge,
    @JsonKey(name: 'visible') this.visible = 1,
    @JsonKey(name: 'uservisible') this.userVisible,
    @JsonKey(name: 'contents')
    final List<CourseContentFileModel> contents =
        const <CourseContentFileModel>[],
    @JsonKey(name: 'dates')
    final List<DateLabelModel> dates = const <DateLabelModel>[],
    @JsonKey(name: 'completion') this.completion,
  }) : _contents = contents,
       _dates = dates;

  factory _$CourseModuleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseModuleModelImplFromJson(json);

  /// Moodle course-module id.
  @override
  @JsonKey(name: 'id')
  final int id;

  /// Display name (e.g. "Test Assignment").
  @override
  @JsonKey(name: 'name')
  final String name;

  /// Module type identifier (e.g. assign, quiz, page).
  @override
  @JsonKey(name: 'modname')
  final String modname;

  /// Activity instance id.
  @override
  @JsonKey(name: 'instance')
  final int instance;

  /// Optional launch URL for the activity.
  @override
  @JsonKey(name: 'url')
  final String? url;

  /// Module-specific icon URL provided by the Moodle theme
  /// (e.g. `theme/image.php/mb2nl/forum/.../monologo`). Surfaced to
  /// the UI so each module renders the exact icon the site
  /// configured instead of relying on a hard-coded glyph map.
  @override
  @JsonKey(name: 'modicon')
  final String? modicon;

  /// Optional activity badge (e.g. `{"badgecontent":"MP4"}` for file
  /// modules). The UI renders this verbatim as the file chip label —
  /// no client-side derivation from mimetype or filename.
  ///
  /// The Moodle API returns `[]` (empty array) for modules that don't
  /// supply a badge and `{...}` (object) for ones that do. We treat
  /// the array as "no badge" so the model stays nullable.
  @override
  @JsonKey(name: 'activitybadge', readValue: _readActivityBadge)
  final ActivityBadgeModel? activityBadge;

  /// Whether the module is visible (0/1).
  @override
  @JsonKey(name: 'visible')
  final int visible;

  /// Whether the current user can see the module (boolean in the
  /// live Moodle response — older docs show 0/1). Accept both shapes
  /// by keeping the model field nullable and normalising in
  /// [toEntity].
  @override
  @JsonKey(name: 'uservisible')
  final bool? userVisible;

  /// Files attached to this module. Always defaulted to `[]` so the
  /// UI doesn't have to null-check.
  final List<CourseContentFileModel> _contents;

  /// Files attached to this module. Always defaulted to `[]` so the
  /// UI doesn't have to null-check.
  @override
  @JsonKey(name: 'contents')
  List<CourseContentFileModel> get contents {
    if (_contents is EqualUnmodifiableListView) return _contents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contents);
  }

  /// Per-event date labels and timestamps returned by Moodle.
  /// We pick the open/close values out of this in [toEntity].
  final List<DateLabelModel> _dates;

  /// Per-event date labels and timestamps returned by Moodle.
  /// We pick the open/close values out of this in [toEntity].
  @override
  @JsonKey(name: 'dates')
  List<DateLabelModel> get dates {
    if (_dates is EqualUnmodifiableListView) return _dates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dates);
  }

  /// Completion state for the current user. Moodle returns `0` (not
  /// completed) or `1` (completed). We map to a nullable bool so the
  /// UI can decide what to render (or nothing at all when the course
  /// doesn't track completion).
  @override
  @JsonKey(name: 'completion')
  final int? completion;

  @override
  String toString() {
    return 'CourseModuleModel(id: $id, name: $name, modname: $modname, instance: $instance, url: $url, modicon: $modicon, activityBadge: $activityBadge, visible: $visible, userVisible: $userVisible, contents: $contents, dates: $dates, completion: $completion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseModuleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.modname, modname) || other.modname == modname) &&
            (identical(other.instance, instance) ||
                other.instance == instance) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.modicon, modicon) || other.modicon == modicon) &&
            (identical(other.activityBadge, activityBadge) ||
                other.activityBadge == activityBadge) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.userVisible, userVisible) ||
                other.userVisible == userVisible) &&
            const DeepCollectionEquality().equals(other._contents, _contents) &&
            const DeepCollectionEquality().equals(other._dates, _dates) &&
            (identical(other.completion, completion) ||
                other.completion == completion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    modname,
    instance,
    url,
    modicon,
    activityBadge,
    visible,
    userVisible,
    const DeepCollectionEquality().hash(_contents),
    const DeepCollectionEquality().hash(_dates),
    completion,
  );

  /// Create a copy of CourseModuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseModuleModelImplCopyWith<_$CourseModuleModelImpl> get copyWith =>
      __$$CourseModuleModelImplCopyWithImpl<_$CourseModuleModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseModuleModelImplToJson(this);
  }
}

abstract class _CourseModuleModel implements CourseModuleModel {
  const factory _CourseModuleModel({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'modname') final String modname,
    @JsonKey(name: 'instance') final int instance,
    @JsonKey(name: 'url') final String? url,
    @JsonKey(name: 'modicon') final String? modicon,
    @JsonKey(name: 'activitybadge', readValue: _readActivityBadge)
    final ActivityBadgeModel? activityBadge,
    @JsonKey(name: 'visible') final int visible,
    @JsonKey(name: 'uservisible') final bool? userVisible,
    @JsonKey(name: 'contents') final List<CourseContentFileModel> contents,
    @JsonKey(name: 'dates') final List<DateLabelModel> dates,
    @JsonKey(name: 'completion') final int? completion,
  }) = _$CourseModuleModelImpl;

  factory _CourseModuleModel.fromJson(Map<String, dynamic> json) =
      _$CourseModuleModelImpl.fromJson;

  /// Moodle course-module id.
  @override
  @JsonKey(name: 'id')
  int get id;

  /// Display name (e.g. "Test Assignment").
  @override
  @JsonKey(name: 'name')
  String get name;

  /// Module type identifier (e.g. assign, quiz, page).
  @override
  @JsonKey(name: 'modname')
  String get modname;

  /// Activity instance id.
  @override
  @JsonKey(name: 'instance')
  int get instance;

  /// Optional launch URL for the activity.
  @override
  @JsonKey(name: 'url')
  String? get url;

  /// Module-specific icon URL provided by the Moodle theme
  /// (e.g. `theme/image.php/mb2nl/forum/.../monologo`). Surfaced to
  /// the UI so each module renders the exact icon the site
  /// configured instead of relying on a hard-coded glyph map.
  @override
  @JsonKey(name: 'modicon')
  String? get modicon;

  /// Optional activity badge (e.g. `{"badgecontent":"MP4"}` for file
  /// modules). The UI renders this verbatim as the file chip label —
  /// no client-side derivation from mimetype or filename.
  ///
  /// The Moodle API returns `[]` (empty array) for modules that don't
  /// supply a badge and `{...}` (object) for ones that do. We treat
  /// the array as "no badge" so the model stays nullable.
  @override
  @JsonKey(name: 'activitybadge', readValue: _readActivityBadge)
  ActivityBadgeModel? get activityBadge;

  /// Whether the module is visible (0/1).
  @override
  @JsonKey(name: 'visible')
  int get visible;

  /// Whether the current user can see the module (boolean in the
  /// live Moodle response — older docs show 0/1). Accept both shapes
  /// by keeping the model field nullable and normalising in
  /// [toEntity].
  @override
  @JsonKey(name: 'uservisible')
  bool? get userVisible;

  /// Files attached to this module. Always defaulted to `[]` so the
  /// UI doesn't have to null-check.
  @override
  @JsonKey(name: 'contents')
  List<CourseContentFileModel> get contents;

  /// Per-event date labels and timestamps returned by Moodle.
  /// We pick the open/close values out of this in [toEntity].
  @override
  @JsonKey(name: 'dates')
  List<DateLabelModel> get dates;

  /// Completion state for the current user. Moodle returns `0` (not
  /// completed) or `1` (completed). We map to a nullable bool so the
  /// UI can decide what to render (or nothing at all when the course
  /// doesn't track completion).
  @override
  @JsonKey(name: 'completion')
  int? get completion;

  /// Create a copy of CourseModuleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseModuleModelImplCopyWith<_$CourseModuleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DateLabelModel _$DateLabelModelFromJson(Map<String, dynamic> json) {
  return _DateLabelModel.fromJson(json);
}

/// @nodoc
mixin _$DateLabelModel {
  /// Human-readable label, e.g. "Opened:" or "Due:".
  @JsonKey(name: 'label')
  String get label => throw _privateConstructorUsedError;

  /// Unix seconds timestamp.
  @JsonKey(name: 'timestamp')
  int? get timestamp => throw _privateConstructorUsedError;

  /// Identifier for the type of date, e.g. `allowsubmissionsfromdate`
  /// or `duedate`. We use this to tell apart the two timestamps the
  /// API exposes for assignments and similar modules.
  @JsonKey(name: 'dataid')
  String get dataid => throw _privateConstructorUsedError;

  /// Serializes this DateLabelModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DateLabelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DateLabelModelCopyWith<DateLabelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateLabelModelCopyWith<$Res> {
  factory $DateLabelModelCopyWith(
    DateLabelModel value,
    $Res Function(DateLabelModel) then,
  ) = _$DateLabelModelCopyWithImpl<$Res, DateLabelModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'label') String label,
    @JsonKey(name: 'timestamp') int? timestamp,
    @JsonKey(name: 'dataid') String dataid,
  });
}

/// @nodoc
class _$DateLabelModelCopyWithImpl<$Res, $Val extends DateLabelModel>
    implements $DateLabelModelCopyWith<$Res> {
  _$DateLabelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DateLabelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? timestamp = freezed,
    Object? dataid = null,
  }) {
    return _then(
      _value.copyWith(
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: freezed == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as int?,
            dataid: null == dataid
                ? _value.dataid
                : dataid // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DateLabelModelImplCopyWith<$Res>
    implements $DateLabelModelCopyWith<$Res> {
  factory _$$DateLabelModelImplCopyWith(
    _$DateLabelModelImpl value,
    $Res Function(_$DateLabelModelImpl) then,
  ) = __$$DateLabelModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'label') String label,
    @JsonKey(name: 'timestamp') int? timestamp,
    @JsonKey(name: 'dataid') String dataid,
  });
}

/// @nodoc
class __$$DateLabelModelImplCopyWithImpl<$Res>
    extends _$DateLabelModelCopyWithImpl<$Res, _$DateLabelModelImpl>
    implements _$$DateLabelModelImplCopyWith<$Res> {
  __$$DateLabelModelImplCopyWithImpl(
    _$DateLabelModelImpl _value,
    $Res Function(_$DateLabelModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DateLabelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? timestamp = freezed,
    Object? dataid = null,
  }) {
    return _then(
      _$DateLabelModelImpl(
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: freezed == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as int?,
        dataid: null == dataid
            ? _value.dataid
            : dataid // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DateLabelModelImpl implements _DateLabelModel {
  const _$DateLabelModelImpl({
    @JsonKey(name: 'label') this.label = '',
    @JsonKey(name: 'timestamp') this.timestamp,
    @JsonKey(name: 'dataid') this.dataid = '',
  });

  factory _$DateLabelModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateLabelModelImplFromJson(json);

  /// Human-readable label, e.g. "Opened:" or "Due:".
  @override
  @JsonKey(name: 'label')
  final String label;

  /// Unix seconds timestamp.
  @override
  @JsonKey(name: 'timestamp')
  final int? timestamp;

  /// Identifier for the type of date, e.g. `allowsubmissionsfromdate`
  /// or `duedate`. We use this to tell apart the two timestamps the
  /// API exposes for assignments and similar modules.
  @override
  @JsonKey(name: 'dataid')
  final String dataid;

  @override
  String toString() {
    return 'DateLabelModel(label: $label, timestamp: $timestamp, dataid: $dataid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateLabelModelImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.dataid, dataid) || other.dataid == dataid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, timestamp, dataid);

  /// Create a copy of DateLabelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateLabelModelImplCopyWith<_$DateLabelModelImpl> get copyWith =>
      __$$DateLabelModelImplCopyWithImpl<_$DateLabelModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DateLabelModelImplToJson(this);
  }
}

abstract class _DateLabelModel implements DateLabelModel {
  const factory _DateLabelModel({
    @JsonKey(name: 'label') final String label,
    @JsonKey(name: 'timestamp') final int? timestamp,
    @JsonKey(name: 'dataid') final String dataid,
  }) = _$DateLabelModelImpl;

  factory _DateLabelModel.fromJson(Map<String, dynamic> json) =
      _$DateLabelModelImpl.fromJson;

  /// Human-readable label, e.g. "Opened:" or "Due:".
  @override
  @JsonKey(name: 'label')
  String get label;

  /// Unix seconds timestamp.
  @override
  @JsonKey(name: 'timestamp')
  int? get timestamp;

  /// Identifier for the type of date, e.g. `allowsubmissionsfromdate`
  /// or `duedate`. We use this to tell apart the two timestamps the
  /// API exposes for assignments and similar modules.
  @override
  @JsonKey(name: 'dataid')
  String get dataid;

  /// Create a copy of DateLabelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateLabelModelImplCopyWith<_$DateLabelModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivityBadgeModel _$ActivityBadgeModelFromJson(Map<String, dynamic> json) {
  return _ActivityBadgeModel.fromJson(json);
}

/// @nodoc
mixin _$ActivityBadgeModel {
  /// Short label rendered on the chip, e.g. `MP4`, `PDF`.
  @JsonKey(name: 'badgecontent')
  String get badgeContent => throw _privateConstructorUsedError;

  /// Style identifier (`badge-none`, etc.). Read for completeness but
  /// not currently surfaced — the UI uses a single chip style.
  @JsonKey(name: 'badgestyle')
  String get badgeStyle => throw _privateConstructorUsedError;

  /// Serializes this ActivityBadgeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityBadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityBadgeModelCopyWith<ActivityBadgeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityBadgeModelCopyWith<$Res> {
  factory $ActivityBadgeModelCopyWith(
    ActivityBadgeModel value,
    $Res Function(ActivityBadgeModel) then,
  ) = _$ActivityBadgeModelCopyWithImpl<$Res, ActivityBadgeModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'badgecontent') String badgeContent,
    @JsonKey(name: 'badgestyle') String badgeStyle,
  });
}

/// @nodoc
class _$ActivityBadgeModelCopyWithImpl<$Res, $Val extends ActivityBadgeModel>
    implements $ActivityBadgeModelCopyWith<$Res> {
  _$ActivityBadgeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityBadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? badgeContent = null, Object? badgeStyle = null}) {
    return _then(
      _value.copyWith(
            badgeContent: null == badgeContent
                ? _value.badgeContent
                : badgeContent // ignore: cast_nullable_to_non_nullable
                      as String,
            badgeStyle: null == badgeStyle
                ? _value.badgeStyle
                : badgeStyle // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActivityBadgeModelImplCopyWith<$Res>
    implements $ActivityBadgeModelCopyWith<$Res> {
  factory _$$ActivityBadgeModelImplCopyWith(
    _$ActivityBadgeModelImpl value,
    $Res Function(_$ActivityBadgeModelImpl) then,
  ) = __$$ActivityBadgeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'badgecontent') String badgeContent,
    @JsonKey(name: 'badgestyle') String badgeStyle,
  });
}

/// @nodoc
class __$$ActivityBadgeModelImplCopyWithImpl<$Res>
    extends _$ActivityBadgeModelCopyWithImpl<$Res, _$ActivityBadgeModelImpl>
    implements _$$ActivityBadgeModelImplCopyWith<$Res> {
  __$$ActivityBadgeModelImplCopyWithImpl(
    _$ActivityBadgeModelImpl _value,
    $Res Function(_$ActivityBadgeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityBadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? badgeContent = null, Object? badgeStyle = null}) {
    return _then(
      _$ActivityBadgeModelImpl(
        badgeContent: null == badgeContent
            ? _value.badgeContent
            : badgeContent // ignore: cast_nullable_to_non_nullable
                  as String,
        badgeStyle: null == badgeStyle
            ? _value.badgeStyle
            : badgeStyle // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityBadgeModelImpl implements _ActivityBadgeModel {
  const _$ActivityBadgeModelImpl({
    @JsonKey(name: 'badgecontent') this.badgeContent = '',
    @JsonKey(name: 'badgestyle') this.badgeStyle = '',
  });

  factory _$ActivityBadgeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityBadgeModelImplFromJson(json);

  /// Short label rendered on the chip, e.g. `MP4`, `PDF`.
  @override
  @JsonKey(name: 'badgecontent')
  final String badgeContent;

  /// Style identifier (`badge-none`, etc.). Read for completeness but
  /// not currently surfaced — the UI uses a single chip style.
  @override
  @JsonKey(name: 'badgestyle')
  final String badgeStyle;

  @override
  String toString() {
    return 'ActivityBadgeModel(badgeContent: $badgeContent, badgeStyle: $badgeStyle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityBadgeModelImpl &&
            (identical(other.badgeContent, badgeContent) ||
                other.badgeContent == badgeContent) &&
            (identical(other.badgeStyle, badgeStyle) ||
                other.badgeStyle == badgeStyle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, badgeContent, badgeStyle);

  /// Create a copy of ActivityBadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityBadgeModelImplCopyWith<_$ActivityBadgeModelImpl> get copyWith =>
      __$$ActivityBadgeModelImplCopyWithImpl<_$ActivityBadgeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityBadgeModelImplToJson(this);
  }
}

abstract class _ActivityBadgeModel implements ActivityBadgeModel {
  const factory _ActivityBadgeModel({
    @JsonKey(name: 'badgecontent') final String badgeContent,
    @JsonKey(name: 'badgestyle') final String badgeStyle,
  }) = _$ActivityBadgeModelImpl;

  factory _ActivityBadgeModel.fromJson(Map<String, dynamic> json) =
      _$ActivityBadgeModelImpl.fromJson;

  /// Short label rendered on the chip, e.g. `MP4`, `PDF`.
  @override
  @JsonKey(name: 'badgecontent')
  String get badgeContent;

  /// Style identifier (`badge-none`, etc.). Read for completeness but
  /// not currently surfaced — the UI uses a single chip style.
  @override
  @JsonKey(name: 'badgestyle')
  String get badgeStyle;

  /// Create a copy of ActivityBadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityBadgeModelImplCopyWith<_$ActivityBadgeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
