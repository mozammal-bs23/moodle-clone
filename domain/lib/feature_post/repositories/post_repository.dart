import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';

/// Repository interface for Post feature
///
/// Defines the contract for CRUD operations against the JSONPlaceholder
/// `/posts` resource. Implementation lives in the data layer.
abstract class PostRepository {
  /// Get all posts
  Future<Result<List<PostEntity>>> getPosts();

  /// Get a single post by [id]
  Future<Result<PostEntity>> getPost(int id);

  /// Create a new [post]
  Future<Result<PostEntity>> createPost(PostEntity post);

  /// Replace a post entirely (PUT)
  Future<Result<PostEntity>> updatePost(PostEntity post);

  /// Partially update a post by [id] (PATCH)
  ///
  /// Only non-null fields are sent.
  Future<Result<PostEntity>> patchPost(int id, {String? title, String? body});

  /// Delete a post by [id]
  Future<Result<void>> deletePost(int id);
}
