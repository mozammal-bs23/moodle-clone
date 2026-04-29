// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HomeItemModel _$$_HomeItemModelFromJson(Map<String, dynamic> json) =>
    _$_HomeItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      category: json['category'] as String?,
      rank: json['rank'] as int,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );

Map<String, dynamic> _$$_HomeItemModelToJson(_$_HomeItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'category': instance.category,
      'rank': instance.rank,
      'isFeatured': instance.isFeatured,
    };

_$_HomeModel _$$_HomeModelFromJson(Map<String, dynamic> json) => _$_HomeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => HomeItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      lastUpdated: json['lastUpdated'] as String,
      isCached: json['isCached'] as bool? ?? false,
    );

Map<String, dynamic> _$$_HomeModelToJson(_$_HomeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'items': instance.items,
      'totalCount': instance.totalCount,
      'lastUpdated': instance.lastUpdated,
      'isCached': instance.isCached,
    };

_$_HomeDetailModel _$$_HomeDetailModelFromJson(Map<String, dynamic> json) =>
    _$_HomeDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => HomeItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      lastUpdated: json['lastUpdated'] as String,
      isCached: json['isCached'] as bool? ?? false,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_HomeDetailModelToJson(_$_HomeDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'items': instance.items,
      'totalCount': instance.totalCount,
      'lastUpdated': instance.lastUpdated,
      'isCached': instance.isCached,
      'description': instance.description,
      'metadata': instance.metadata,
    };
