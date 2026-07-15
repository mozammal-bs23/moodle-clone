import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for partially updating a post (PATCH /posts/{id})
@injectable
class PatchPostUseCase {
  /// Creates a new instance of PatchPostUseCase
  const PatchPostUseCase(this._repository);

  final PostRepository _repository;

  /// Execute the use case
  ///
  /// [id] - Unique identifier of the post
  /// [title] - New title, if changing
  /// [body] - New body, if changing
  Future<Result<PostEntity>> call(int id, {String? title, String? body}) =>
      _repository.patchPost(id, title: title, body: body);
}
