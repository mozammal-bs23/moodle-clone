import 'package:flutter_boilerplate_core/utils/failure/app_failure.dart';
import 'package:flutter_boilerplate_domain/feature_home/entities/home_entity.dart';
import 'package:flutter_boilerplate_domain/feature_home/repositories/home_repository.dart';
import 'package:flutter_boilerplate_domain/feature_home/usecases/get_home_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_home_data_usecase_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late GetHomeDataUseCase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetHomeDataUseCase(mockRepository);
  });

  group('GetHomeDataUseCase', () {
    final tHomeEntity = HomeEntity(
      id: '1',
      title: 'Test Home',
      subtitle: 'Test Subtitle',
      imageUrl: 'https://example.com/image.jpg',
      items: const [],
      totalCount: 0,
      lastUpdated: DateTime.now(),
    );

    test('calls repository.getHomeData and returns data on success', () async {
      // Arrange
      when(
        mockRepository.getHomeData(),
      ).thenAnswer((_) async => (tHomeEntity, null));

      // Act
      final (data, error) = await usecase();

      // Assert
      expect(data, equals(tHomeEntity));
      expect(error, isNull);
      verify(mockRepository.getHomeData()).called(1);
    });

    test('returns failure when repository fails', () async {
      // Arrange
      const tFailure = NetworkFailure(message: 'Connection error');
      when(
        mockRepository.getHomeData(),
      ).thenAnswer((_) async => (null, tFailure));

      // Act
      final (data, error) = await usecase();

      // Assert
      expect(data, isNull);
      expect(error, equals(tFailure));
      verify(mockRepository.getHomeData()).called(1);
    });

    test('passes forceRefresh parameter to repository', () async {
      // Arrange
      when(
        mockRepository.getHomeData(),
      ).thenAnswer((_) async => (tHomeEntity, null));

      // Act
      await usecase(forceRefresh: true);

      // Assert
      verify(mockRepository.getHomeData()).called(1);
    });
  });
}
