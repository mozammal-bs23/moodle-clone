import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_data/feature_post/models/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'post_remote_datasource.g.dart';

/// Remote data source for post feature API calls
///
/// Uses Retrofit for type-safe HTTP client generation against
/// https://jsonplaceholder.typicode.com/posts. Demonstrates all five
/// HTTP verbs: GET, POST, PUT, PATCH, DELETE.
@RestApi()
abstract class PostRemoteDatasource {
  /// Creates an instance of [PostRemoteDatasource]
  ///
  /// [dio] - configured Dio instance with interceptors
  /// [baseUrl] - overrides the shared Dio instance's base URL for this
  /// datasource only (applied per-request by the generated client)
  factory PostRemoteDatasource(Dio dio, {String baseUrl}) =
      _PostRemoteDatasource;

  /// GET /posts
  /// Fetch all posts
  @GET('/posts')
  Future<List<PostModel>> getPosts();

  /// GET /posts/{id}
  /// Fetch a single post by id
  @GET('/posts/{id}')
  Future<PostModel> getPost(@Path('id') int id);

  /// POST /posts
  /// Create a new post
  @POST('/posts')
  Future<PostModel> createPost(@Body() PostModel post);

  /// PUT /posts/{id}
  /// Fully replace a post
  @PUT('/posts/{id}')
  Future<PostModel> updatePost(@Path('id') int id, @Body() PostModel post);

  /// PATCH /posts/{id}
  /// Partially update a post
  @PATCH('/posts/{id}')
  Future<PostModel> patchPost(
    @Path('id') int id,
    @Body() Map<String, dynamic> changes,
  );

  /// DELETE /posts/{id}
  /// Delete a post
  @DELETE('/posts/{id}')
  Future<void> deletePost(@Path('id') int id);
}
