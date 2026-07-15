import 'package:flutter_boilerplate_core/utils/failure/app_failure.dart';
import 'package:flutter_boilerplate_domain/feature_post/entities/post_entity.dart';
import 'package:flutter_boilerplate_domain/feature_post/repositories/post_repository.dart';
import 'package:flutter_boilerplate_domain/feature_post/usecases/patch_post_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'patch_post_usecase_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late PatchPostUseCase usecase;
  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
    usecase = PatchPostUseCase(mockRepository);
  });

  group('PatchPostUseCase', () {
    const tPatchedPost = PostEntity(
      id: 1,
      userId: 1,
      title: 'Patched Title',
      body: 'Original Body',
    );

    test('calls repository.patchPost with only the changed field', () async {
      when(
        mockRepository.patchPost(1, title: 'Patched Title'),
      ).thenAnswer((_) async => (tPatchedPost, null));

      final (data, error) = await usecase(1, title: 'Patched Title');

      expect(data, equals(tPatchedPost));
      expect(error, isNull);
      verify(
        mockRepository.patchPost(1, title: 'Patched Title'),
      ).called(1);
    });

    test('returns failure when repository fails', () async {
      const tFailure = NetworkFailure(message: 'Not found', statusCode: 404);
      when(
        mockRepository.patchPost(1, title: 'Patched Title'),
      ).thenAnswer((_) async => (null, tFailure));

      final (data, error) = await usecase(1, title: 'Patched Title');

      expect(data, isNull);
      expect(error, equals(tFailure));
    });
  });
}
