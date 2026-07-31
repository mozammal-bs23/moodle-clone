import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/feature_auth/data/datasources/login_remote_datasource.dart';
import 'package:flutter_boilerplate/feature_auth/data/repositories/login_repository_impl.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
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

  // Builds a DioException for a given status code (used to simulate 4xx/5xx
  // / 429 responses without going through the full request pipeline).
  DioException dioExceptionForStatus(int statusCode) {
    return DioException(
      requestOptions: RequestOptions(path: '/login/token.php'),
      response: Response<dynamic>(
        requestOptions: RequestOptions(path: '/login/token.php'),
        statusCode: statusCode,
      ),
      type: DioExceptionType.badResponse,
    );
  }

  group('LoginRepositoryImpl — Dio error mapping', () {
    test('connection timeout → NetworkFailure with timeout message', () async {
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
      expect(failure!.code, 'NETWORK_FAILURE');
      expect(failure.message, contains('took too long'));
    });

    test('503 → "server is currently unavailable"', () async {
      when(mockRemote.login(any)).thenThrow(dioExceptionForStatus(503));

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'Student@123',
      );

      expect(token, isNull);
      expect(failure, isNotNull);
      expect(failure!.code, 'NETWORK_FAILURE');
      expect(failure.message, contains('server is currently unavailable'));
    });

    test('429 → "Too many login attempts"', () async {
      when(mockRemote.login(any)).thenThrow(dioExceptionForStatus(429));

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'Student@123',
      );

      expect(token, isNull);
      expect(failure, isNotNull);
      expect(failure!.message, contains('Too many login attempts'));
    });

    test('other 4xx → generic NetworkFailure', () async {
      when(mockRemote.login(any)).thenThrow(dioExceptionForStatus(404));

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'Student@123',
      );

      expect(token, isNull);
      expect(failure, isNotNull);
      expect(failure, isA<NetworkFailure>());
      expect(failure!.code, 'NETWORK_FAILURE');
      expect((failure as NetworkFailure).statusCode, 404);
    });
  });
}
