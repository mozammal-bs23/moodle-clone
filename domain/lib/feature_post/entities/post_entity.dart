// ignore_for_file: sort_constructors_first
import 'package:meta/meta.dart';

/// Post entity representing a JSONPlaceholder post
///
/// This is a pure Dart object with no dependencies on frameworks.
@immutable
class PostEntity {
  /// Unique identifier (null for a post not yet created)
  final int? id;

  /// ID of the user who authored the post
  final int userId;

  /// Post title
  final String title;

  /// Post body content
  final String body;

  /// Creates a new PostEntity instance
  const PostEntity({
    required this.userId,
    required this.title,
    required this.body,
    this.id,
  });

  /// Creates a copy of this entity with specified attributes replaced
  PostEntity copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
  }) {
    return PostEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PostEntity &&
        other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode => Object.hash(id, userId, title, body);

  @override
  String toString() => 'PostEntity{id: $id, title: $title}';
}
