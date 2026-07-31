// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_section_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseSectionModel _$CourseSectionModelFromJson(Map<String, dynamic> json) {
  return _CourseSectionModel.fromJson(json);
}

/// @nodoc
mixin _$CourseSectionModel {
  /// Moodle section id.
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;

  /// Section name (e.g. "General").
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;

  /// HTML summary text.
  @JsonKey(name: 'summary')
  String get summary => throw _privateConstructorUsedError;

  /// Summary format (1 = HTML, 0 = Moodle, 2 = plain, 4 = Markdown).
  @JsonKey(name: 'summaryformat')
  int get summaryFormat => throw _privateConstructorUsedError;

  /// Visibility (0/1).
  @JsonKey(name: 'visible')
  int get visible => throw _privateConstructorUsedError;

  /// Section position on the course page (0 = top).
  @JsonKey(name: 'section')
  int get order => throw _privateConstructorUsedError;

  /// Modules in this section.
  @JsonKey(name: 'modules')
  List<CourseModuleModel> get modules => throw _privateConstructorUsedError;

  /// Serializes this CourseSectionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseSectionModelCopyWith<CourseSectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseSectionModelCopyWith<$Res> {
  factory $CourseSectionModelCopyWith(
    CourseSectionModel value,
    $Res Function(CourseSectionModel) then,
  ) = _$CourseSectionModelCopyWithImpl<$Res, CourseSectionModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'summary') String summary,
    @JsonKey(name: 'summaryformat') int summaryFormat,
    @JsonKey(name: 'visible') int visible,
    @JsonKey(name: 'section') int order,
    @JsonKey(name: 'modules') List<CourseModuleModel> modules,
  });
}

/// @nodoc
class _$CourseSectionModelCopyWithImpl<$Res, $Val extends CourseSectionModel>
    implements $CourseSectionModelCopyWith<$Res> {
  _$CourseSectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? summary = null,
    Object? summaryFormat = null,
    Object? visible = null,
    Object? order = null,
    Object? modules = null,
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
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            summaryFormat: null == summaryFormat
                ? _value.summaryFormat
                : summaryFormat // ignore: cast_nullable_to_non_nullable
                      as int,
            visible: null == visible
                ? _value.visible
                : visible // ignore: cast_nullable_to_non_nullable
                      as int,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            modules: null == modules
                ? _value.modules
                : modules // ignore: cast_nullable_to_non_nullable
                      as List<CourseModuleModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseSectionModelImplCopyWith<$Res>
    implements $CourseSectionModelCopyWith<$Res> {
  factory _$$CourseSectionModelImplCopyWith(
    _$CourseSectionModelImpl value,
    $Res Function(_$CourseSectionModelImpl) then,
  ) = __$$CourseSectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'summary') String summary,
    @JsonKey(name: 'summaryformat') int summaryFormat,
    @JsonKey(name: 'visible') int visible,
    @JsonKey(name: 'section') int order,
    @JsonKey(name: 'modules') List<CourseModuleModel> modules,
  });
}

/// @nodoc
class __$$CourseSectionModelImplCopyWithImpl<$Res>
    extends _$CourseSectionModelCopyWithImpl<$Res, _$CourseSectionModelImpl>
    implements _$$CourseSectionModelImplCopyWith<$Res> {
  __$$CourseSectionModelImplCopyWithImpl(
    _$CourseSectionModelImpl _value,
    $Res Function(_$CourseSectionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? summary = null,
    Object? summaryFormat = null,
    Object? visible = null,
    Object? order = null,
    Object? modules = null,
  }) {
    return _then(
      _$CourseSectionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        summaryFormat: null == summaryFormat
            ? _value.summaryFormat
            : summaryFormat // ignore: cast_nullable_to_non_nullable
                  as int,
        visible: null == visible
            ? _value.visible
            : visible // ignore: cast_nullable_to_non_nullable
                  as int,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        modules: null == modules
            ? _value._modules
            : modules // ignore: cast_nullable_to_non_nullable
                  as List<CourseModuleModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseSectionModelImpl implements _CourseSectionModel {
  const _$CourseSectionModelImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') this.name = '',
    @JsonKey(name: 'summary') this.summary = '',
    @JsonKey(name: 'summaryformat') this.summaryFormat = 1,
    @JsonKey(name: 'visible') this.visible = 1,
    @JsonKey(name: 'section') this.order = 0,
    @JsonKey(name: 'modules')
    final List<CourseModuleModel> modules = const <CourseModuleModel>[],
  }) : _modules = modules;

  factory _$CourseSectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseSectionModelImplFromJson(json);

  /// Moodle section id.
  @override
  @JsonKey(name: 'id')
  final int id;

  /// Section name (e.g. "General").
  @override
  @JsonKey(name: 'name')
  final String name;

  /// HTML summary text.
  @override
  @JsonKey(name: 'summary')
  final String summary;

  /// Summary format (1 = HTML, 0 = Moodle, 2 = plain, 4 = Markdown).
  @override
  @JsonKey(name: 'summaryformat')
  final int summaryFormat;

  /// Visibility (0/1).
  @override
  @JsonKey(name: 'visible')
  final int visible;

  /// Section position on the course page (0 = top).
  @override
  @JsonKey(name: 'section')
  final int order;

  /// Modules in this section.
  final List<CourseModuleModel> _modules;

  /// Modules in this section.
  @override
  @JsonKey(name: 'modules')
  List<CourseModuleModel> get modules {
    if (_modules is EqualUnmodifiableListView) return _modules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modules);
  }

  @override
  String toString() {
    return 'CourseSectionModel(id: $id, name: $name, summary: $summary, summaryFormat: $summaryFormat, visible: $visible, order: $order, modules: $modules)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseSectionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.summaryFormat, summaryFormat) ||
                other.summaryFormat == summaryFormat) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other._modules, _modules));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    summary,
    summaryFormat,
    visible,
    order,
    const DeepCollectionEquality().hash(_modules),
  );

  /// Create a copy of CourseSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseSectionModelImplCopyWith<_$CourseSectionModelImpl> get copyWith =>
      __$$CourseSectionModelImplCopyWithImpl<_$CourseSectionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseSectionModelImplToJson(this);
  }
}

abstract class _CourseSectionModel implements CourseSectionModel {
  const factory _CourseSectionModel({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') final String name,
    @JsonKey(name: 'summary') final String summary,
    @JsonKey(name: 'summaryformat') final int summaryFormat,
    @JsonKey(name: 'visible') final int visible,
    @JsonKey(name: 'section') final int order,
    @JsonKey(name: 'modules') final List<CourseModuleModel> modules,
  }) = _$CourseSectionModelImpl;

  factory _CourseSectionModel.fromJson(Map<String, dynamic> json) =
      _$CourseSectionModelImpl.fromJson;

  /// Moodle section id.
  @override
  @JsonKey(name: 'id')
  int get id;

  /// Section name (e.g. "General").
  @override
  @JsonKey(name: 'name')
  String get name;

  /// HTML summary text.
  @override
  @JsonKey(name: 'summary')
  String get summary;

  /// Summary format (1 = HTML, 0 = Moodle, 2 = plain, 4 = Markdown).
  @override
  @JsonKey(name: 'summaryformat')
  int get summaryFormat;

  /// Visibility (0/1).
  @override
  @JsonKey(name: 'visible')
  int get visible;

  /// Section position on the course page (0 = top).
  @override
  @JsonKey(name: 'section')
  int get order;

  /// Modules in this section.
  @override
  @JsonKey(name: 'modules')
  List<CourseModuleModel> get modules;

  /// Create a copy of CourseSectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseSectionModelImplCopyWith<_$CourseSectionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
