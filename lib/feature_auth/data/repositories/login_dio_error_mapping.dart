import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/feature_auth/data/repositories/login_auth_messages.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// Builds a [NetworkFailure] for a [DioException] with a user-friendly
/// message derived from the Dio error type and HTTP status code when
/// available.
///
/// Kept separate from `LoginRepositoryImpl` so the repository itself stays
/// focused on the success/failure-state machine and this helper can be
/// unit-tested in isolation.
NetworkFailure mapDioErrorToNetworkFailure(DioException e) {
  final statusCode = e.response?.statusCode;
  return NetworkFailure(
    message: _messageForDioError(e, statusCode),
    statusCode: statusCode,
    responseBody: e.response?.toString(),
  );
}

/// User-facing message for a given [DioException].
///
/// Without this, the cubit would forward Dio's raw `e.message`, which is
/// implementation-level ("Connection timed out", "XMLHttpRequest error",
/// etc.) and unhelpful to end users.
String _messageForDioError(DioException e, int? statusCode) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return loginNetworkErrorTimeout;
    case DioExceptionType.connectionError:
      return loginNetworkErrorUnreachable;
    case DioExceptionType.cancel:
      return loginNetworkErrorCancelled;
    case DioExceptionType.badCertificate:
      return loginNetworkErrorBadCertificate;
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      if (statusCode == 429) {
        return loginNetworkErrorRateLimited;
      }
      if (statusCode != null && statusCode >= 500) {
        return loginNetworkErrorServerUnavailable;
      }
      return loginNetworkErrorOther;
  }
}
