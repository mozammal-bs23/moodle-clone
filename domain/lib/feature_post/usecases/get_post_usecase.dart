import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fetching a single post by id (GET /posts/{id})
@injectable
class GetPostUseCase {
  /// Creates a new instance of GetPostUseCase
  const GetPostUseCase(this._repository);

  final PostRepository _repository;

  /// Execute the use case
  ///
  /// [id] - Unique identifier of the post
  Future<Result<PostEntity>> call(int id) => _repository.getPost(id);
}
