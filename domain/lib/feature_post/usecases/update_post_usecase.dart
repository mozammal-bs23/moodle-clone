import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fully replacing a post (PUT /posts/{id})
@injectable
class UpdatePostUseCase {
  /// Creates a new instance of UpdatePostUseCase
  const UpdatePostUseCase(this._repository);

  final PostRepository _repository;

  /// Execute the use case
  ///
  /// [post] - The full replacement post (must include a non-null id)
  Future<Result<PostEntity>> call(PostEntity post) =>
      _repository.updatePost(post);
}
