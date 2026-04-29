import 'package:flutter_boilerplate_core/utils/failure/app_failure.dart';
import 'package:flutter_boilerplate_domain/feature_home/entities/home_entity.dart';
import 'package:flutter_boilerplate_domain/feature_home/repositories/home_repository.dart';
import 'package:flutter_boilerplate_domain/feature_home/usecases/get_home_detail_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_home_detail_usecase_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late GetHomeDetailUseCase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetHomeDetailUseCase(mockRepository);
  });

  group('GetHomeDetailUseCase', () {
    const testId = 'test-id-123';
    final tHomeEntity = HomeEntity(
      id: testId,
      title: 'Test Detail',
      subtitle: 'Test Detail Subtitle',
      imageUrl: 'https://example.com/detail.jpg',
      items: const [],
      totalCount: 1,
      lastUpdated: DateTime.now(),
    );

    test('calls repository.getHomeDetail with correct id', () async {
      // Arrange
      when(
        mockRepository.getHomeDetail(testId),
      ).thenAnswer((_) async => (tHomeEntity, null));

      // Act
      final (data, error) = await usecase(testId);

      // Assert
      expect(data, equals(tHomeEntity));
      expect(error, isNull);
      verify(mockRepository.getHomeDetail(testId)).called(1);
    });

    test('returns failure when repository fails', () async {
      // Arrange
      const tFailure = NetworkFailure(message: 'Not found', statusCode: 404);
      when(
        mockRepository.getHomeDetail(testId),
      ).thenAnswer((_) async => (null, tFailure));

      // Act
      final (data, error) = await usecase(testId);

      // Assert
      expect(data, isNull);
      expect(error, equals(tFailure));
      verify(mockRepository.getHomeDetail(testId)).called(1);
    });

    test('propagates correct id parameter', () async {
      // Arrange
      when(
        mockRepository.getHomeDetail('id-1'),
      ).thenAnswer((_) async => (tHomeEntity, null));
      when(
        mockRepository.getHomeDetail('id-2'),
      ).thenAnswer((_) async => (tHomeEntity, null));

      // Act
      await usecase('id-1');
      await usecase('id-2');

      // Assert
      verify(mockRepository.getHomeDetail('id-1')).called(1);
      verify(mockRepository.getHomeDetail('id-2')).called(1);
    });
  });
}
