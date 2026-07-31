import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/feature_auth/data/datasources/login_remote_datasource.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_request_model.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tests for the Moodle `POST /login/token.php` contract:
/// `application/x-www-form-urlencoded` body with `username`, `password`,
/// `service=moodle_mobile_app`. JSON response with `token`+`privatetoken`
/// on success or `error`+`errorcode` on failure.
void main() {
  setUp(() {
    // Keep the datasource reachable for the request-model tests; the
    // datasource itself is exercised end-to-end via the repository test.
    LoginRemoteDatasource(Dio(), baseUrl: 'https://example.test');
  });

  group('LoginRequestModel.toFormBody', () {
    test('matches the Moodle token.php contract', () {
      const request = LoginRequestModel(
        username: 'student',
        password: 'Student@123',
      );

      // Exact ordering — Moodle accepts any order, but the canonical
      // encoding is asserted here so a future refactor doesn't drop a
      // field.
      expect(
        request.toFormBody(),
        'username=student'
        '&password=Student%40123'
        '&service=moodle_mobile_app',
      );
    });

    test('percent-encodes reserved characters', () {
      // `&`, `+`, `=`, `@` must be percent-encoded so the server can
      // split the body into key=value pairs unambiguously.
      const request = LoginRequestModel(
        username: 'a b',
        password: 'p&w+d=e',
      );

      final body = request.toFormBody();

      // Per application/x-www-form-urlencoded, spaces encode as `+`
      // (not `%20`). The implementation uses Uri.encodeQueryComponent
      // which follows that convention.
      expect(body, contains('username=a+b'));
      expect(body, contains('password=p%26w%2Bd%3De'));
      expect(body, isNot(contains('&w+')));
    });
  });

  group('LoginResponseModel.fromJson', () {
    test('parses a success body with token and privatetoken', () {
      final model = LoginResponseModel.fromJson(<String, dynamic>{
        'token': 'public-token-abc',
        'privatetoken': 'private-token-xyz',
      });

      expect(model.token, 'public-token-abc');
      expect(model.privatetoken, 'private-token-xyz');
      expect(model.error, isNull);
      expect(model.errorcode, isNull);
    });

    test('parses a failure body with error, errorcode, stacktrace', () {
      final model = LoginResponseModel.fromJson(<String, dynamic>{
        'error': 'Invalid login, please try again',
        'errorcode': 'invalidlogin',
        'stacktrace': '/var/www/.../login/lib.php:42',
        'debuginfo': 'Stack trace suppressed.',
        'reproductionlink': 'https://example.test/reproduce/1',
      });

      expect(model.error, 'Invalid login, please try again');
      expect(model.errorcode, 'invalidlogin');
      expect(model.token, isNull);
    });

    test('parses a failure body that uses `message` instead of `error`', () {
      // Older Moodle REST plugin variants omit `error` and rely on
      // `message`. The model must preserve it so the repository can fall
      // back to it.
      final model = LoginResponseModel.fromJson(<String, dynamic>{
        'message': 'Invalid login, please try again',
        'errorcode': 'invalidlogin',
      });

      expect(model.message, 'Invalid login, please try again');
      expect(model.error, isNull);
    });
  });
}
