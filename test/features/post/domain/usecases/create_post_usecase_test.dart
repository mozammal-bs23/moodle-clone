import 'package:flutter_boilerplate_core/utils/failure/app_failure.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:flutter_boilerplate_domain/feature_post/usecases/create_post_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'create_post_usecase_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late CreatePostUseCase usecase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    usecase = CreatePostUseCase(mockRepository);
  });

  group('CreatePostUseCase', () {
    const tNewPost = PostEntity(userId: 1, title: 'New Title', body: 'New Body');
    const tCreatedPost = PostEntity(
      id: 101,
      userId: 1,
      title: 'New Title',
      body: 'New Body',
    );

    test('calls repository.createPost with correct post', () async {
      when(
        mockRepository.createPost(tNewPost),
      ).thenAnswer((_) async => (tCreatedPost, null));

      final (data, error) = await usecase(tNewPost);

      expect(data, equals(tCreatedPost));
      expect(error, isNull);
      verify(mockRepository.createPost(tNewPost)).called(1);
    });

    test('returns failure when repository fails', () async {
      const tFailure = NetworkFailure(message: 'Server error', statusCode: 500);
      when(
        mockRepository.createPost(tNewPost),
      ).thenAnswer((_) async => (null, tFailure));

      final (data, error) = await usecase(tNewPost);

      expect(data, isNull);
      expect(error, equals(tFailure));
      verify(mockRepository.createPost(tNewPost)).called(1);
    });
  });
}
