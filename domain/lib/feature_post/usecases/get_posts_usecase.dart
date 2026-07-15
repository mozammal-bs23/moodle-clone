import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fetching all posts (GET /posts)
@injectable
class GetPostsUseCase {
  /// Creates a new instance of GetPostsUseCase
  const GetPostsUseCase(this._repository);

  final PostRepository _repository;

  /// Execute the use case
  Future<Result<List<PostEntity>>> call() => _repository.getPosts();
}
