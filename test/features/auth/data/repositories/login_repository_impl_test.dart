import 'package:flutter_boilerplate/feature_auth/data/datasources/login_remote_datasource.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_response_model.dart';
import 'package:flutter_boilerplate/feature_auth/data/repositories/login_repository_impl.dart';
import 'package:flutter_boilerplate/feature_auth/domain/entities/login_token_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDatasource])
void main() {
  late LoginRepositoryImpl repository;
  late MockLoginRemoteDatasource mockRemote;

  setUp(() {
    mockRemote = MockLoginRemoteDatasource();
    repository = LoginRepositoryImpl(remoteDatasource: mockRemote);
  });

  group('LoginRepositoryImpl.login — happy and core sad paths', () {
    test('returns LoginTokenEntity on success', () async {
      when(mockRemote.login(any)).thenAnswer(
        (_) async => const LoginResponseModel(
          token: 'public-token-abc',
          privatetoken: 'private-token-xyz',
        ),
      );

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'Student@123',
      );

      expect(failure, isNull);
      expect(token, isA<LoginTokenEntity>());
      expect(token!.token, 'public-token-abc');
      expect(token.privateToken, 'private-token-xyz');
      verify(mockRemote.login(any)).called(1);
    });

    test('returns AuthFailure when the success body is missing a token',
        () async {
      when(mockRemote.login(any)).thenAnswer(
        (_) async => const LoginResponseModel(),
      );

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'Student@123',
      );

      expect(token, isNull);
      expect(failure, isNotNull);
      expect(failure!.message, contains('without a token'));
    });
  });
}
