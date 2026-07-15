import 'package:flutter_boilerplate_core/utils/failure/app_failure.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:flutter_boilerplate_domain/feature_post/usecases/get_posts_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_posts_usecase_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late GetPostsUseCase usecase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    usecase = GetPostsUseCase(mockRepository);
  });

  group('GetPostsUseCase', () {
    const tPosts = [
      PostEntity(id: 1, userId: 1, title: 'Title 1', body: 'Body 1'),
      PostEntity(id: 2, userId: 1, title: 'Title 2', body: 'Body 2'),
    ];

    test('calls repository.getPosts and returns the list', () async {
      when(mockRepository.getPosts()).thenAnswer((_) async => (tPosts, null));

      final (data, error) = await usecase();

      expect(data, equals(tPosts));
      expect(error, isNull);
      verify(mockRepository.getPosts()).called(1);
    });

    test('returns failure when repository fails', () async {
      const tFailure = NetworkFailure(message: 'Server error', statusCode: 500);
      when(
        mockRepository.getPosts(),
      ).thenAnswer((_) async => (null, tFailure));

      final (data, error) = await usecase();

      expect(data, isNull);
      expect(error, equals(tFailure));
      verify(mockRepository.getPosts()).called(1);
    });
  });
}
