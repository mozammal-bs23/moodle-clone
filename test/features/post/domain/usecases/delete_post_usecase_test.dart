import 'package:flutter_boilerplate_core/utils/failure/app_failure.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:flutter_boilerplate_domain/feature_post/usecases/delete_post_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'delete_post_usecase_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late DeletePostUseCase usecase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    usecase = DeletePostUseCase(mockRepository);
  });

  group('DeletePostUseCase', () {
    test('calls repository.deletePost with correct id', () async {
      when(mockRepository.deletePost(1)).thenAnswer((_) async => (null, null));

      final (_, error) = await usecase(1);

      expect(error, isNull);
      verify(mockRepository.deletePost(1)).called(1);
    });

    test('returns failure when repository fails', () async {
      const tFailure = NetworkFailure(message: 'Not found', statusCode: 404);
      when(
        mockRepository.deletePost(1),
      ).thenAnswer((_) async => (null, tFailure));

      final (_, error) = await usecase(1);

      expect(error, equals(tFailure));
      verify(mockRepository.deletePost(1)).called(1);
    });
  });
}
