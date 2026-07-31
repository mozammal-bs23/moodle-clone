import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_request_model.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_response_model.dart';

/// Remote data source for the Moodle login endpoint.
///
/// Thin wrapper around [Dio] that POSTs to `/login/token.php` on the Moodle
/// site and returns a parsed [LoginResponseModel]. The datasource is
/// deliberately dumb: it does **not** interpret the response — both the
/// success and the error body shapes are valid `200 OK` responses, so the
/// repository layer is the right place to translate Moodle's
/// `{error, errorcode}` body into an `AppFailure`.
///
/// Registered as a lazy singleton in `lib/src/injection/di.dart`.
class LoginRemoteDatasource {
  /// Creates a [LoginRemoteDatasource].
  ///
  /// `dio` is the shared `Dio` instance from the core DI module.
  ///
  /// [baseUrl] is the fully-qualified Moodle site URL. The datasource POSTs
  /// to `'$baseUrl/login/token.php'` directly rather than relying on the
  /// shared Dio's `baseUrl` because `ApiClient` (in `core/`) mutates that
  /// field when constructed, which would clobber the JSONPlaceholder URL
  /// used by `feature_post`.
  const LoginRemoteDatasource(
    this._dio, {
    required this.baseUrl,
  });

  final Dio _dio;

  /// Base URL of the Moodle web service (e.g.
  /// `https://lmsmobile.ahnafmuttaki.com`).
  final String baseUrl;

  /// Performs `POST /login/token.php` and returns the parsed response model.
  ///
  /// Throws the underlying [DioException] on transport-level failure so the
  /// repository can map it to a `NetworkFailure`.
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _dio.post<dynamic>(
      '$baseUrl/login/token.php',
      data: request.toFormBody(),
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );

    final raw = response.data;
    if (raw is! Map) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: 'Unexpected response shape from /login/token.php: '
            '${raw.runtimeType}',
      );
    }

    return LoginResponseModel.fromJson(Map<String, dynamic>.from(raw));
  }
}
