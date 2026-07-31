import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/feature_auth/data/datasources/login_remote_datasource.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_request_model.dart';
import 'package:flutter_boilerplate/feature_auth/data/models/login_response_model.dart';
import 'package:flutter_boilerplate/feature_auth/data/repositories/login_auth_messages.dart';
import 'package:flutter_boilerplate/feature_auth/data/repositories/login_dio_error_mapping.dart';
import 'package:flutter_boilerplate/feature_auth/domain/entities/login_token_entity.dart';
import 'package:flutter_boilerplate/feature_auth/domain/repositories/login_repository.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// Implementation of [LoginRepository] that delegates to
/// [LoginRemoteDatasource] and translates transport / protocol-level
/// errors into the project's `AppFailure` hierarchy.
///
/// Because Moodle returns HTTP 200 for both success and failure, this
/// class is the single source of truth for distinguishing the two cases —
/// it inspects the parsed [LoginResponseModel] for `errorcode` and either
/// `error` or `message` to decide which `Result` variant to produce.
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

      final failureMessage = _extractErrorMessage(response);
      if (failureMessage != null) {
        return (null, AuthFailure(message: failureMessage));
      }

      final token = response.token;
      if (token == null || token.isEmpty) {
        return (
          null,
          const AuthFailure(message: loginServerMissingTokenMessage),
        );
      }

      return (
        LoginTokenEntity(token: token, privateToken: response.privatetoken),
        null,
      );
    } on DioException catch (e) {
      return (null, mapDioErrorToNetworkFailure(e));
    } catch (e, st) {
      return (null, _mapUnknownError(e, st));
    }
  }

  /// Returns the user-facing failure message, or `null` if the response
  /// isn't a failure.
  ///
  /// Special-cases `errorcode == invalidlogin` so the user sees an
  /// explicit "username or password is incorrect" sentence instead of the
  /// generic server text. Otherwise prefers `error` → `message` →
  /// `errorcode`.
  String? _extractErrorMessage(LoginResponseModel response) {
    if (response.errorcode == loginInvalidLoginErrorcode) {
      return loginInvalidLoginUserMessage;
    }
    if (response.error != null && response.error!.isNotEmpty) {
      return response.error;
    }
    if (response.message != null && response.message!.isNotEmpty) {
      return response.message;
    }
    if (response.errorcode != null && response.errorcode!.isNotEmpty) {
      return response.errorcode;
    }
    return null;
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
