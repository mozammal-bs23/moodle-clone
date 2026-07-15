import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for creating a new post (POST /posts)
@injectable
class CreatePostUseCase {
  /// Creates a new instance of CreatePostUseCase
  const CreatePostUseCase(this._repository);

  final PostRepository _repository;

  /// Execute the use case
  ///
  /// [post] - The post to create (id is ignored by the server)
  Future<Result<PostEntity>> call(PostEntity post) =>
      _repository.createPost(post);
}
