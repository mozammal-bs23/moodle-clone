import 'package:flutter_boilerplate/feature_auth/data/datasources/login_remote_datasource.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_response_model.dart';
import 'package:flutter_boilerplate/feature_auth/data/repositories/login_repository_impl.dart';
import 'package:flutter_boilerplate/feature_auth/data/repositories/login_auth_messages.dart';
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

  group('LoginRepositoryImpl — auth-failure message translation', () {
    test('invalidlogin → explicit username/password message', () async {
      // When Moodle's `errorcode` is `invalidlogin`, the user must see an
      // explicit "incorrect username or password" sentence rather than
      // the generic server text.
      when(mockRemote.login(any)).thenAnswer(
        (_) async => const LoginResponseModel(
          error: 'Invalid login, please try again',
          errorcode: loginInvalidLoginErrorcode,
        ),
      );

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'wrong',
      );

      expect(token, isNull);
      expect(failure, isNotNull);
      expect(failure!.message, loginInvalidLoginUserMessage);
    });

    test('falls back to `message` when `error` is missing', () async {
      // Some Moodle REST plugins return only the `message` field (no
      // top-level `error`). The `invalidlogin` code still wins and the
      // user sees the explicit "incorrect username or password" message.
      when(mockRemote.login(any)).thenAnswer(
        (_) async => const LoginResponseModel(
          message: 'Invalid login, please try again',
          errorcode: loginInvalidLoginErrorcode,
        ),
      );

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'wrong',
      );

      expect(token, isNull);
      expect(failure, isNotNull);
      expect(failure!.message, loginInvalidLoginUserMessage);
    });

    test('preserves the server message for non-credential failures',
        () async {
      // Failure codes other than `invalidlogin` (e.g. `accountlocked`,
      // `usernotconfirmed`) must surface the server's message verbatim so
      // the user sees the actual reason.
      when(mockRemote.login(any)).thenAnswer(
        (_) async => const LoginResponseModel(
          error: 'Your account is locked. Please contact your teacher.',
          errorcode: 'accountlocked',
        ),
      );

      final (token, failure) = await repository.login(
        username: 'student',
        password: 'Student@123',
      );

      expect(token, isNull);
      expect(failure, isNotNull);
      expect(
        failure!.message,
        'Your account is locked. Please contact your teacher.',
      );
    });
  });
}
