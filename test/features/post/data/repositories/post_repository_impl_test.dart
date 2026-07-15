import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_data/feature_post/datasources/post_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_post/models/post_model.dart';
import 'package:flutter_boilerplate_data/feature_post/repositories/post_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'post_repository_impl_test.mocks.dart';

@GenerateMocks([PostRemoteDatasource])
void main() {
  late PostRepositoryImpl repository;
  late MockPostRemoteDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockPostRemoteDatasource();
    repository = PostRepositoryImpl(remoteDatasource: mockDatasource);
  });

  const tPostModel = PostModel(
    id: 1,
    userId: 1,
    title: 'Test Title',
    body: 'Test Body',
  );

  final tDioException = DioException(
    requestOptions: RequestOptions(path: '/posts/1'),
    response: Response(
      requestOptions: RequestOptions(path: '/posts/1'),
      statusCode: 404,
    ),
    type: DioExceptionType.badResponse,
  );

  group('getPosts', () {
    test('returns list of entities on success', () async {
      when(
        mockDatasource.getPosts(),
      ).thenAnswer((_) async => [tPostModel]);

      final (data, error) = await repository.getPosts();

      expect(data, isNotNull);
      expect(data!.length, 1);
      expect(data.first.id, 1);
      expect(error, isNull);
    });

    test('maps DioException to NetworkFailure', () async {
      when(mockDatasource.getPosts()).thenThrow(tDioException);

      final (data, error) = await repository.getPosts();

      expect(data, isNull);
      expect(error, isNotNull);
      expect(error!.code, 'NETWORK_FAILURE');
    });
  });

  group('getPost', () {
    test('returns entity on success', () async {
      when(mockDatasource.getPost(1)).thenAnswer((_) async => tPostModel);

      final (data, error) = await repository.getPost(1);

      expect(data?.id, 1);
      expect(error, isNull);
    });

    test('maps DioException to NetworkFailure', () async {
      when(mockDatasource.getPost(1)).thenThrow(tDioException);

      final (data, error) = await repository.getPost(1);

      expect(data, isNull);
      expect(error?.code, 'NETWORK_FAILURE');
    });
  });

  group('createPost', () {
    test('returns created entity on success', () async {
      when(
        mockDatasource.createPost(any),
      ).thenAnswer((_) async => tPostModel);

      final (data, error) = await repository.createPost(
        tPostModel.toEntity(),
      );

      expect(data?.id, 1);
      expect(error, isNull);
    });
  });

  group('updatePost', () {
    test('returns updated entity on success', () async {
      when(
        mockDatasource.updatePost(1, any),
      ).thenAnswer((_) async => tPostModel);

      final (data, error) = await repository.updatePost(
        tPostModel.toEntity(),
      );

      expect(data?.id, 1);
      expect(error, isNull);
    });
  });

  group('patchPost', () {
    test('sends only non-null fields and returns entity on success', () async {
      when(
        mockDatasource.patchPost(1, {'title': 'New Title'}),
      ).thenAnswer((_) async => tPostModel);

      final (data, error) = await repository.patchPost(1, title: 'New Title');

      expect(data?.id, 1);
      expect(error, isNull);
      verify(mockDatasource.patchPost(1, {'title': 'New Title'})).called(1);
    });
  });

  group('deletePost', () {
    test('completes with no error on success', () async {
      when(mockDatasource.deletePost(1)).thenAnswer((_) async {});

      final (_, error) = await repository.deletePost(1);

      expect(error, isNull);
      verify(mockDatasource.deletePost(1)).called(1);
    });

    test('maps DioException to NetworkFailure', () async {
      when(mockDatasource.deletePost(1)).thenThrow(tDioException);

      final (_, error) = await repository.deletePost(1);

      expect(error?.code, 'NETWORK_FAILURE');
    });
  });
}
