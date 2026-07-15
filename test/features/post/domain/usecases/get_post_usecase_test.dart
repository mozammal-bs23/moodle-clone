import 'package:flutter_boilerplate_core/utils/failure/app_failure.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:flutter_boilerplate_domain/feature_post/usecases/get_post_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_post_usecase_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late GetPostUseCase usecase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    usecase = GetPostUseCase(mockRepository);
  });

  group('GetPostUseCase', () {
    const tPost = PostEntity(id: 1, userId: 1, title: 'Title', body: 'Body');

    test('calls repository.getPost with correct id', () async {
      when(mockRepository.getPost(1)).thenAnswer((_) async => (tPost, null));

      final (data, error) = await usecase(1);

      expect(data, equals(tPost));
      expect(error, isNull);
      verify(mockRepository.getPost(1)).called(1);
    });

    test('returns failure when repository fails', () async {
      const tFailure = NetworkFailure(message: 'Not found', statusCode: 404);
      when(
        mockRepository.getPost(1),
      ).thenAnswer((_) async => (null, tFailure));

      final (data, error) = await usecase(1);

      expect(data, isNull);
      expect(error, equals(tFailure));
      verify(mockRepository.getPost(1)).called(1);
    });
  });
}
