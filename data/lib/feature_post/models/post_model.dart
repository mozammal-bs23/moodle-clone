// ignore_for_file: invalid_annotation_target
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

/// Data model for a JSONPlaceholder post
///
/// This is the data layer representation of a post.
/// Used for JSON serialization/deserialization against
/// https://jsonplaceholder.typicode.com/posts.
@freezed
class PostModel with _$PostModel {
  /// Creates an instance of [PostModel]
  ///
  /// [id] - unique identifier (null for a post not yet created)
  /// [userId] - id of the authoring user
  /// [title] - post title
  /// [body] - post body content
  const factory PostModel({
    required int userId,
    required String title,
    required String body,
    @JsonKey(includeIfNull: false) int? id,
  }) = _PostModel;

  /// Creates a [PostModel] from JSON map
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

/// Extension methods to convert between data models and domain entities
extension PostModelX on PostModel {
  /// Convert data model to domain entity
  PostEntity toEntity() {
    return PostEntity(id: id, userId: userId, title: title, body: body);
  }
}

/// Extension methods to convert between domain entities and data models
extension PostEntityX on PostEntity {
  /// Convert domain entity to data model
  PostModel toModel() {
    return PostModel(id: id, userId: userId, title: title, body: body);
  }
}
