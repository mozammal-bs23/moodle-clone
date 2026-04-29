import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/lib/flutter_boilerplate_domain.dart';

part 'home_model.freezed.dart';
part 'home_model.g.dart';
/// Data model for home items
/// 
/// This is the data layer representation of a home item.
/// Used for JSON serialization/deserialization.
@freezed
class HomeItemModel with _$HomeItemModel {
  const factory HomeItemModel({
    required String id,
    required String title,
    String? description,
    String? thumbnailUrl,
    String? category,
    required int rank,
    @Default(false) bool isFeatured,
  }) = _HomeItemModel;
  
  factory HomeItemModel.fromJson(Map<String, dynamic> json) =>
      _$HomeItemModelFromJson(json);
}

/// Data model for home entity
/// 
/// This is the data layer representation of home data.
/// Used for network responses and local storage.
@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel({
    required String id,
    required String title,
    String? subtitle,
    String? imageUrl,
    required List<HomeItemModel> items,
    required int totalCount,
    required String lastUpdated,
    @Default(false) bool isCached,
  }) = _HomeModel;
  
  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

/// Data model for home detail - extends HomeModel with additional fields
@freezed
class HomeDetailModel with _$HomeDetailModel {
  const factory HomeDetailModel({
    required String id,
    required String title,
    String? subtitle,
    String? imageUrl,
    required List<HomeItemModel> items,
    required int totalCount,
    required String lastUpdated,
    @Default(false) bool isCached,
    String? description,
    Map<String, dynamic>? metadata,
  }) = _HomeDetailModel;
  
  factory HomeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDetailModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$HomeDetailModelToJson(this);
}

/// Extension methods to convert between data models and domain entities
extension HomeModelX on HomeModel {
  /// Convert data model to domain entity
  HomeEntity toEntity() {
    return HomeEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      items: items.map((e) => e.toEntity()).toList(),
      totalCount: totalCount,
      lastUpdated: DateTime.parse(lastUpdated),
      isCached: isCached,
    );
  }
}

extension HomeItemModelX on HomeItemModel {
  /// Convert data model to domain entity
  HomeItemEntity toEntity() {
    return HomeItemEntity(
      id: id,
      title: title,
      description: description,
      thumbnailUrl: thumbnailUrl,
      category: category,
      rank: rank,
      isFeatured: isFeatured,
    );
  }
}

extension HomeDetailModelX on HomeDetailModel {
  /// Convert data model to domain entity
  HomeEntity toEntity() {
    return HomeEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      items: items.map((e) => e.toEntity()).toList(),
      totalCount: totalCount,
      lastUpdated: DateTime.parse(lastUpdated),
      isCached: isCached,
    );
  }
}
