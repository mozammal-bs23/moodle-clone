import 'package:flutter_boilerplate_core/utils/failure/app_failure.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:flutter_boilerplate_domain/feature_post/usecases/update_post_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'update_post_usecase_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late UpdatePostUseCase usecase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    usecase = UpdatePostUseCase(mockRepository);
  });

  group('UpdatePostUseCase', () {
    const tPost = PostEntity(
      id: 1,
      userId: 1,
      title: 'Updated Title',
      body: 'Updated Body',
    );

    test('calls repository.updatePost with correct post', () async {
      when(
        mockRepository.updatePost(tPost),
      ).thenAnswer((_) async => (tPost, null));

      final (data, error) = await usecase(tPost);

      expect(data, equals(tPost));
      expect(error, isNull);
      verify(mockRepository.updatePost(tPost)).called(1);
    });

    test('returns failure when repository fails', () async {
      const tFailure = NetworkFailure(message: 'Not found', statusCode: 404);
      when(
        mockRepository.updatePost(tPost),
      ).thenAnswer((_) async => (null, tFailure));

      final (data, error) = await usecase(tPost);

      expect(data, isNull);
      expect(error, equals(tFailure));
      verify(mockRepository.updatePost(tPost)).called(1);
    });
  });
}
