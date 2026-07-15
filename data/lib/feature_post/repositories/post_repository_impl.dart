import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_data/feature_post/datasources/post_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_post/models/post_model.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:injectable/injectable.dart';

/// Implementation of [PostRepository]
///
/// Delegates directly to [PostRemoteDatasource] with no local caching -
/// JSONPlaceholder is a fake API whose writes don't persist, so caching
/// them would be misleading.
@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  /// Creates a new instance of [PostRepositoryImpl]
  PostRepositoryImpl({required PostRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  final PostRemoteDatasource _remoteDatasource;

  @override
  Future<Result<List<PostEntity>>> getPosts() async {
    try {
      final response = await _remoteDatasource.getPosts();
      return (response.map((e) => e.toEntity()).toList(), null);
    } on DioException catch (e) {
      return (null, _mapDioError(e));
    } catch (e, st) {
      return (null, _mapUnknownError(e, st));
    }
  }

  @override
  Future<Result<PostEntity>> getPost(int id) async {
    try {
      final response = await _remoteDatasource.getPost(id);
      return (response.toEntity(), null);
    } on DioException catch (e) {
      return (null, _mapDioError(e));
    } catch (e, st) {
      return (null, _mapUnknownError(e, st));
    }
  }

  @override
  Future<Result<PostEntity>> createPost(PostEntity post) async {
    try {
      final response = await _remoteDatasource.createPost(post.toModel());
      return (response.toEntity(), null);
    } on DioException catch (e) {
      return (null, _mapDioError(e));
    } catch (e, st) {
      return (null, _mapUnknownError(e, st));
    }
  }

  @override
  Future<Result<PostEntity>> updatePost(PostEntity post) async {
    try {
      final response = await _remoteDatasource.updatePost(
        post.id!,
        post.toModel(),
      );
      return (response.toEntity(), null);
    } on DioException catch (e) {
      return (null, _mapDioError(e));
    } catch (e, st) {
      return (null, _mapUnknownError(e, st));
    }
  }

  @override
  Future<Result<PostEntity>> patchPost(
    int id, {
    String? title,
    String? body,
  }) async {
    try {
      final changes = <String, dynamic>{
        if (title != null) 'title': title,
        if (body != null) 'body': body,
      };
      final response = await _remoteDatasource.patchPost(id, changes);
      return (response.toEntity(), null);
    } on DioException catch (e) {
      return (null, _mapDioError(e));
    } catch (e, st) {
      return (null, _mapUnknownError(e, st));
    }
  }

  @override
  Future<Result<void>> deletePost(int id) async {
    try {
      await _remoteDatasource.deletePost(id);
      return (null, null);
    } on DioException catch (e) {
      return (null, _mapDioError(e));
    } catch (e, st) {
      return (null, _mapUnknownError(e, st));
    }
  }

  NetworkFailure _mapDioError(DioException e) {
    return NetworkFailure(
      message: e.message ?? 'Network error',
      statusCode: e.response?.statusCode,
      responseBody: e.response?.toString(),
    );
  }

  UnknownFailure _mapUnknownError(Object e, StackTrace st) {
    return UnknownFailure(
      message: 'Unexpected error: $e',
      exception: e,
      stackTrace: st,
    );
  }
}
