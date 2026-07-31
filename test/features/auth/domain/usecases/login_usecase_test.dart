import 'package:flutter_boilerplate/feature_auth/domain/entities/login_token_entity.dart';
import 'package:flutter_boilerplate/feature_auth/domain/repositories/login_repository.dart';
import 'package:flutter_boilerplate/feature_auth/domain/usecases/login_usecase.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_usecase_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  late LoginUseCase useCase;
  late MockLoginRepository mockRepository;

  setUp(() {
    mockRepository = MockLoginRepository();
    useCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    const tEntity = LoginTokenEntity(
      token: 'public-token-abc',
      privateToken: 'private-token-xyz',
    );

    test('forwards credentials to the repository and returns the entity',
        () async {
      when(
        mockRepository.login(username: 'student', password: 'Student@123'),
      ).thenAnswer((_) async => (tEntity, null));

      final (token, failure) =
          await useCase(username: 'student', password: 'Student@123');

      expect(failure, isNull);
      expect(token, tEntity);
      verify(
        mockRepository.login(username: 'student', password: 'Student@123'),
      ).called(1);
    });

    test('propagates the repository failure untouched', () async {
      const tFailure = AuthFailure(message: 'Invalid login, please try again');
      when(
        mockRepository.login(username: 'student', password: 'wrong'),
      ).thenAnswer((_) async => (null, tFailure));

      final (token, failure) =
          await useCase(username: 'student', password: 'wrong');

      expect(token, isNull);
      expect(failure, tFailure);
      verify(
        mockRepository.login(username: 'student', password: 'wrong'),
      ).called(1);
    });
  });
}
