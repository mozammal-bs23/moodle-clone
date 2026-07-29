import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/feature_auth/data/datasources/login_remote_datasource.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_request_model.dart';
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

  group('LoginRepositoryImpl.login', () {
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
      verify(
        mockRemote.login(
          const LoginRequestModel(
            username: 'student',
            password: 'Student@123',
          ),
        ),
      ).called(1);
    });

    test('returns AuthFailure when Moodle replies with an error body',
        () async {
      when(mockRemote.login(any)).thenAnswer(
        (_) async => const LoginResponseModel(
          error: 'Invalid login, please try again',
          errorcode: 'invalidlogin',
        ),
      );

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'wrong',
      );

      expect(token, isNull);
      expect(failure, isNotNull);
      // AuthFailure is part of the AppFailure sealed hierarchy; the message
      // must surface the original Moodle error verbatim.
      expect(failure!.message, 'Invalid login, please try again');
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

    test('maps DioException to NetworkFailure', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/login/token.php'),
        type: DioExceptionType.connectionTimeout,
      );
      when(mockRemote.login(any)).thenThrow(dioException);

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'Student@123',
      );

      expect(token, isNull);
      expect(failure, isNotNull);
      // NetworkFailure.code is the AppFailure base 'code' (NETWORK_FAILURE).
      expect(failure!.code, 'NETWORK_FAILURE');
    });
  });
}
