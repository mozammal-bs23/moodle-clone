// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

HomeItemModel _$HomeItemModelFromJson(Map<String, dynamic> json) {
  return _HomeItemModel.fromJson(json);
}

/// @nodoc
mixin _$HomeItemModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeItemModelCopyWith<HomeItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeItemModelCopyWith<$Res> {
  factory $HomeItemModelCopyWith(
          HomeItemModel value, $Res Function(HomeItemModel) then) =
      _$HomeItemModelCopyWithImpl<$Res, HomeItemModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? thumbnailUrl,
      String? category,
      int rank,
      bool isFeatured});
}

/// @nodoc
class _$HomeItemModelCopyWithImpl<$Res, $Val extends HomeItemModel>
    implements $HomeItemModelCopyWith<$Res> {
  _$HomeItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? category = freezed,
    Object? rank = null,
    Object? isFeatured = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeItemModelCopyWith<$Res>
    implements $HomeItemModelCopyWith<$Res> {
  factory _$$_HomeItemModelCopyWith(
          _$_HomeItemModel value, $Res Function(_$_HomeItemModel) then) =
      __$$_HomeItemModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? thumbnailUrl,
      String? category,
      int rank,
      bool isFeatured});
}

/// @nodoc
class __$$_HomeItemModelCopyWithImpl<$Res>
    extends _$HomeItemModelCopyWithImpl<$Res, _$_HomeItemModel>
    implements _$$_HomeItemModelCopyWith<$Res> {
  __$$_HomeItemModelCopyWithImpl(
      _$_HomeItemModel _value, $Res Function(_$_HomeItemModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? category = freezed,
    Object? rank = null,
    Object? isFeatured = null,
  }) {
    return _then(_$_HomeItemModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HomeItemModel implements _HomeItemModel {
  const _$_HomeItemModel(
      {required this.id,
      required this.title,
      this.description,
      this.thumbnailUrl,
      this.category,
      required this.rank,
      this.isFeatured = false});

  factory _$_HomeItemModel.fromJson(Map<String, dynamic> json) =>
      _$$_HomeItemModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? thumbnailUrl;
  @override
  final String? category;
  @override
  final int rank;
  @override
  @JsonKey()
  final bool isFeatured;

  @override
  String toString() {
    return 'HomeItemModel(id: $id, title: $title, description: $description, thumbnailUrl: $thumbnailUrl, category: $category, rank: $rank, isFeatured: $isFeatured)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeItemModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      thumbnailUrl, category, rank, isFeatured);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeItemModelCopyWith<_$_HomeItemModel> get copyWith =>
      __$$_HomeItemModelCopyWithImpl<_$_HomeItemModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HomeItemModelToJson(
      this,
    );
  }
}

abstract class _HomeItemModel implements HomeItemModel {
  const factory _HomeItemModel(
      {required final String id,
      required final String title,
      final String? description,
      final String? thumbnailUrl,
      final String? category,
      required final int rank,
      final bool isFeatured}) = _$_HomeItemModel;

  factory _HomeItemModel.fromJson(Map<String, dynamic> json) =
      _$_HomeItemModel.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get thumbnailUrl;
  @override
  String? get category;
  @override
  int get rank;
  @override
  bool get isFeatured;
  @override
  @JsonKey(ignore: true)
  _$$_HomeItemModelCopyWith<_$_HomeItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return _HomeModel.fromJson(json);
}

/// @nodoc
mixin _$HomeModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<HomeItemModel> get items => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  String get lastUpdated => throw _privateConstructorUsedError;
  bool get isCached => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeModelCopyWith<HomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeModelCopyWith<$Res> {
  factory $HomeModelCopyWith(HomeModel value, $Res Function(HomeModel) then) =
      _$HomeModelCopyWithImpl<$Res, HomeModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? subtitle,
      String? imageUrl,
      List<HomeItemModel> items,
      int totalCount,
      String lastUpdated,
      bool isCached});
}

/// @nodoc
class _$HomeModelCopyWithImpl<$Res, $Val extends HomeModel>
    implements $HomeModelCopyWith<$Res> {
  _$HomeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? imageUrl = freezed,
    Object? items = null,
    Object? totalCount = null,
    Object? lastUpdated = null,
    Object? isCached = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HomeItemModel>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
      isCached: null == isCached
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeModelCopyWith<$Res> implements $HomeModelCopyWith<$Res> {
  factory _$$_HomeModelCopyWith(
          _$_HomeModel value, $Res Function(_$_HomeModel) then) =
      __$$_HomeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? subtitle,
      String? imageUrl,
      List<HomeItemModel> items,
      int totalCount,
      String lastUpdated,
      bool isCached});
}

/// @nodoc
class __$$_HomeModelCopyWithImpl<$Res>
    extends _$HomeModelCopyWithImpl<$Res, _$_HomeModel>
    implements _$$_HomeModelCopyWith<$Res> {
  __$$_HomeModelCopyWithImpl(
      _$_HomeModel _value, $Res Function(_$_HomeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? imageUrl = freezed,
    Object? items = null,
    Object? totalCount = null,
    Object? lastUpdated = null,
    Object? isCached = null,
  }) {
    return _then(_$_HomeModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HomeItemModel>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
      isCached: null == isCached
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HomeModel implements _HomeModel {
  const _$_HomeModel(
      {required this.id,
      required this.title,
      this.subtitle,
      this.imageUrl,
      required final List<HomeItemModel> items,
      required this.totalCount,
      required this.lastUpdated,
      this.isCached = false})
      : _items = items;

  factory _$_HomeModel.fromJson(Map<String, dynamic> json) =>
      _$$_HomeModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String? imageUrl;
  final List<HomeItemModel> _items;
  @override
  List<HomeItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int totalCount;
  @override
  final String lastUpdated;
  @override
  @JsonKey()
  final bool isCached;

  @override
  String toString() {
    return 'HomeModel(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, items: $items, totalCount: $totalCount, lastUpdated: $lastUpdated, isCached: $isCached)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.isCached, isCached) ||
                other.isCached == isCached));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      subtitle,
      imageUrl,
      const DeepCollectionEquality().hash(_items),
      totalCount,
      lastUpdated,
      isCached);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeModelCopyWith<_$_HomeModel> get copyWith =>
      __$$_HomeModelCopyWithImpl<_$_HomeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HomeModelToJson(
      this,
    );
  }
}

abstract class _HomeModel implements HomeModel {
  const factory _HomeModel(
      {required final String id,
      required final String title,
      final String? subtitle,
      final String? imageUrl,
      required final List<HomeItemModel> items,
      required final int totalCount,
      required final String lastUpdated,
      final bool isCached}) = _$_HomeModel;

  factory _HomeModel.fromJson(Map<String, dynamic> json) =
      _$_HomeModel.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  String? get imageUrl;
  @override
  List<HomeItemModel> get items;
  @override
  int get totalCount;
  @override
  String get lastUpdated;
  @override
  bool get isCached;
  @override
  @JsonKey(ignore: true)
  _$$_HomeModelCopyWith<_$_HomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeDetailModel _$HomeDetailModelFromJson(Map<String, dynamic> json) {
  return _HomeDetailModel.fromJson(json);
}

/// @nodoc
mixin _$HomeDetailModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<HomeItemModel> get items => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  String get lastUpdated => throw _privateConstructorUsedError;
  bool get isCached => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeDetailModelCopyWith<HomeDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDetailModelCopyWith<$Res> {
  factory $HomeDetailModelCopyWith(
          HomeDetailModel value, $Res Function(HomeDetailModel) then) =
      _$HomeDetailModelCopyWithImpl<$Res, HomeDetailModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? subtitle,
      String? imageUrl,
      List<HomeItemModel> items,
      int totalCount,
      String lastUpdated,
      bool isCached,
      String? description,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$HomeDetailModelCopyWithImpl<$Res, $Val extends HomeDetailModel>
    implements $HomeDetailModelCopyWith<$Res> {
  _$HomeDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? imageUrl = freezed,
    Object? items = null,
    Object? totalCount = null,
    Object? lastUpdated = null,
    Object? isCached = null,
    Object? description = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HomeItemModel>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
      isCached: null == isCached
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeDetailModelCopyWith<$Res>
    implements $HomeDetailModelCopyWith<$Res> {
  factory _$$_HomeDetailModelCopyWith(
          _$_HomeDetailModel value, $Res Function(_$_HomeDetailModel) then) =
      __$$_HomeDetailModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? subtitle,
      String? imageUrl,
      List<HomeItemModel> items,
      int totalCount,
      String lastUpdated,
      bool isCached,
      String? description,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$_HomeDetailModelCopyWithImpl<$Res>
    extends _$HomeDetailModelCopyWithImpl<$Res, _$_HomeDetailModel>
    implements _$$_HomeDetailModelCopyWith<$Res> {
  __$$_HomeDetailModelCopyWithImpl(
      _$_HomeDetailModel _value, $Res Function(_$_HomeDetailModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? imageUrl = freezed,
    Object? items = null,
    Object? totalCount = null,
    Object? lastUpdated = null,
    Object? isCached = null,
    Object? description = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$_HomeDetailModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HomeItemModel>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
      isCached: null == isCached
          ? _value.isCached
          : isCached // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_HomeDetailModel implements _HomeDetailModel {
  const _$_HomeDetailModel(
      {required this.id,
      required this.title,
      this.subtitle,
      this.imageUrl,
      required final List<HomeItemModel> items,
      required this.totalCount,
      required this.lastUpdated,
      this.isCached = false,
      this.description,
      final Map<String, dynamic>? metadata})
      : _items = items,
        _metadata = metadata;

  factory _$_HomeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$$_HomeDetailModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String? imageUrl;
  final List<HomeItemModel> _items;
  @override
  List<HomeItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int totalCount;
  @override
  final String lastUpdated;
  @override
  @JsonKey()
  final bool isCached;
  @override
  final String? description;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'HomeDetailModel(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, items: $items, totalCount: $totalCount, lastUpdated: $lastUpdated, isCached: $isCached, description: $description, metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeDetailModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.isCached, isCached) ||
                other.isCached == isCached) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      subtitle,
      imageUrl,
      const DeepCollectionEquality().hash(_items),
      totalCount,
      lastUpdated,
      isCached,
      description,
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeDetailModelCopyWith<_$_HomeDetailModel> get copyWith =>
      __$$_HomeDetailModelCopyWithImpl<_$_HomeDetailModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HomeDetailModelToJson(
      this,
    );
  }
}

abstract class _HomeDetailModel implements HomeDetailModel {
  const factory _HomeDetailModel(
      {required final String id,
      required final String title,
      final String? subtitle,
      final String? imageUrl,
      required final List<HomeItemModel> items,
      required final int totalCount,
      required final String lastUpdated,
      final bool isCached,
      final String? description,
      final Map<String, dynamic>? metadata}) = _$_HomeDetailModel;

  factory _HomeDetailModel.fromJson(Map<String, dynamic> json) =
      _$_HomeDetailModel.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  String? get imageUrl;
  @override
  List<HomeItemModel> get items;
  @override
  int get totalCount;
  @override
  String get lastUpdated;
  @override
  bool get isCached;
  @override
  String? get description;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$_HomeDetailModelCopyWith<_$_HomeDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}
