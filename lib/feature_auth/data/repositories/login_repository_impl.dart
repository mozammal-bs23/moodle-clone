import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/feature_auth/data/datasources/login_remote_datasource.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_request_model.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_response_model.dart';
import 'package:flutter_boilerplate/feature_auth/domain/entities/login_token_entity.dart';
import 'package:flutter_boilerplate/feature_auth/domain/repositories/login_repository.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// Implementation of [LoginRepository] that delegates to
/// [LoginRemoteDatasource] and translates transport / protocol-level errors
/// into the project's `AppFailure` hierarchy.
///
/// Because Moodle returns HTTP 200 for both success and failure, this class
/// is the single source of truth for distinguishing the two cases — it
/// inspects the parsed [LoginResponseModel] for the `errorcode` field and
/// maps a non-null `error` to an `AuthFailure` rather than letting the
/// caller see an ambiguous "success with null token" result.
///
/// Registered as a lazy singleton in `lib/src/injection/di.dart`.
class LoginRepositoryImpl implements LoginRepository {
  /// Creates a [LoginRepositoryImpl].
  const LoginRepositoryImpl({
    required LoginRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  final LoginRemoteDatasource _remoteDatasource;

  @override
  Future<Result<LoginTokenEntity>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _remoteDatasource.login(
        LoginRequestModel(username: username, password: password),
      );

      // Moodle encodes errors in a 200 OK response body as
      // `{error, errorcode}`. Surface them as AuthFailure so the UI can
      // show the user the original human-readable message verbatim.
      if (response.error != null && response.error!.isNotEmpty) {
        return (
          null,
          AuthFailure(message: response.error!),
        );
      }

      final token = response.token;
      if (token == null || token.isEmpty) {
        return (
          null,
          const AuthFailure(
            message: 'Server returned a success response without a token',
          ),
        );
      }

      return (
        LoginTokenEntity(
          token: token,
          privateToken: response.privatetoken,
        ),
        null,
      );
    } on DioException catch (e) {
      return (null, _mapDioError(e));
    } catch (e, st) {
      return (null, _mapUnknownError(e, st));
    }
  }

  /// Maps a transport-level [DioException] to a [NetworkFailure].
  NetworkFailure _mapDioError(DioException e) {
    return NetworkFailure(
      message: e.message ?? 'Network error',
      statusCode: e.response?.statusCode,
      responseBody: e.response?.toString(),
    );
  }

  /// Maps any non-Dio exception to an [UnknownFailure].
  UnknownFailure _mapUnknownError(Object e, StackTrace st) {
    return UnknownFailure(
      message: 'Unexpected error: $e',
      exception: e,
      stackTrace: st,
    );
  }
}
