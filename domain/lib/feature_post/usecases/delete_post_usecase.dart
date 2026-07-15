import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for deleting a post (DELETE /posts/{id})
@injectable
class DeletePostUseCase {
  /// Creates a new instance of DeletePostUseCase
  const DeletePostUseCase(this._repository);

  final PostRepository _repository;

  /// Execute the use case
  ///
  /// [id] - Unique identifier of the post to delete
  Future<Result<void>> call(int id) => _repository.deletePost(id);
}
