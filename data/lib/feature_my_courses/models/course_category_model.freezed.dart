// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseCategoryModel _$CourseCategoryModelFromJson(Map<String, dynamic> json) {
  return _CourseCategoryModel.fromJson(json);
}

/// @nodoc
mixin _$CourseCategoryModel {
  /// Numeric id.
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;

  /// Display name.
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;

  /// Parent category id (`0` for top-level).
  @JsonKey(name: 'parent')
  int get parent => throw _privateConstructorUsedError;

  /// Serializes this CourseCategoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseCategoryModelCopyWith<CourseCategoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCategoryModelCopyWith<$Res> {
  factory $CourseCategoryModelCopyWith(
    CourseCategoryModel value,
    $Res Function(CourseCategoryModel) then,
  ) = _$CourseCategoryModelCopyWithImpl<$Res, CourseCategoryModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'parent') int parent,
  });
}

/// @nodoc
class _$CourseCategoryModelCopyWithImpl<$Res, $Val extends CourseCategoryModel>
    implements $CourseCategoryModelCopyWith<$Res> {
  _$CourseCategoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? parent = null}) {
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
            parent: null == parent
                ? _value.parent
                : parent // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseCategoryModelImplCopyWith<$Res>
    implements $CourseCategoryModelCopyWith<$Res> {
  factory _$$CourseCategoryModelImplCopyWith(
    _$CourseCategoryModelImpl value,
    $Res Function(_$CourseCategoryModelImpl) then,
  ) = __$$CourseCategoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'parent') int parent,
  });
}

/// @nodoc
class __$$CourseCategoryModelImplCopyWithImpl<$Res>
    extends _$CourseCategoryModelCopyWithImpl<$Res, _$CourseCategoryModelImpl>
    implements _$$CourseCategoryModelImplCopyWith<$Res> {
  __$$CourseCategoryModelImplCopyWithImpl(
    _$CourseCategoryModelImpl _value,
    $Res Function(_$CourseCategoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? parent = null}) {
    return _then(
      _$CourseCategoryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        parent: null == parent
            ? _value.parent
            : parent // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseCategoryModelImpl implements _CourseCategoryModel {
  const _$CourseCategoryModelImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') this.name = '',
    @JsonKey(name: 'parent') this.parent = 0,
  });

  factory _$CourseCategoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseCategoryModelImplFromJson(json);

  /// Numeric id.
  @override
  @JsonKey(name: 'id')
  final int id;

  /// Display name.
  @override
  @JsonKey(name: 'name')
  final String name;

  /// Parent category id (`0` for top-level).
  @override
  @JsonKey(name: 'parent')
  final int parent;

  @override
  String toString() {
    return 'CourseCategoryModel(id: $id, name: $name, parent: $parent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseCategoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, parent);

  /// Create a copy of CourseCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseCategoryModelImplCopyWith<_$CourseCategoryModelImpl> get copyWith =>
      __$$CourseCategoryModelImplCopyWithImpl<_$CourseCategoryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseCategoryModelImplToJson(this);
  }
}

abstract class _CourseCategoryModel implements CourseCategoryModel {
  const factory _CourseCategoryModel({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') final String name,
    @JsonKey(name: 'parent') final int parent,
  }) = _$CourseCategoryModelImpl;

  factory _CourseCategoryModel.fromJson(Map<String, dynamic> json) =
      _$CourseCategoryModelImpl.fromJson;

  /// Numeric id.
  @override
  @JsonKey(name: 'id')
  int get id;

  /// Display name.
  @override
  @JsonKey(name: 'name')
  String get name;

  /// Parent category id (`0` for top-level).
  @override
  @JsonKey(name: 'parent')
  int get parent;

  /// Create a copy of CourseCategoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseCategoryModelImplCopyWith<_$CourseCategoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
