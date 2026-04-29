import 'dart:async';

/// Base class for all application failures
/// This sealed class hierarchy represents all possible failures in the app
abstract class AppFailure implements Exception {
  /// Unique error code for identification
  final String code;

  /// Human-readable error message
  final String message;

  /// Optional stack trace for debugging
  final StackTrace? stackTrace;

  /// Creates a new AppFailure
  const AppFailure({
    required this.code,
    required this.message,
    this.stackTrace,
  });

  /// Convert to JSON map
  Map<String, dynamic> toJson();

  @override
  String toString() => 'AppFailure(code: $code, message: $message)';
}

/// Failure that occurs during network operations
class NetworkFailure extends AppFailure {
  /// HTTP status code if available
  final int? statusCode;

  /// Response body from the server
  final String? responseBody;

  /// Creates a NetworkFailure
  const NetworkFailure({
    required String message,
    this.statusCode,
    this.responseBody,
    StackTrace? stackTrace,
  }) : super(
          code: 'NETWORK_FAILURE',
          message: message,
          stackTrace: stackTrace,
        );

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'statusCode': statusCode,
        'responseBody': responseBody,
      };
}

/// Failure that occurs during local storage operations
class CacheFailure extends AppFailure {
  /// Key that caused the failure
  final String? key;

  /// Creates a CacheFailure
  const CacheFailure({
    required String message,
    this.key,
    StackTrace? stackTrace,
  }) : super(
          code: 'CACHE_FAILURE',
          message: message,
          stackTrace: stackTrace,
        );

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'key': key,
      };
}

/// Failure for validation errors
class ValidationFailure extends AppFailure {
  /// Field that failed validation
  final String? field;

  /// List of validation error messages
  final List<String> errors;

  /// Creates a ValidationFailure
  const ValidationFailure({
    required String message,
    this.field,
    List<String>? errors,
    StackTrace? stackTrace,
  })  : errors = errors ?? const [],
        super(
          code: 'VALIDATION_FAILURE',
          message: message,
          stackTrace: stackTrace,
        );

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'field': field,
        'errors': errors,
      };
}

/// Failure for authentication/authorization errors
class AuthFailure extends AppFailure {
  /// Whether token refresh is possible
  final bool canRefresh;

  /// Creates an AuthFailure
  const AuthFailure({
    required String message,
    this.canRefresh = false,
    StackTrace? stackTrace,
  }) : super(
          code: 'AUTH_FAILURE',
          message: message,
          stackTrace: stackTrace,
        );

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'canRefresh': canRefresh,
      };
}

/// Unknown/unexpected failure
class UnknownFailure extends AppFailure {
  /// Original exception that caused this failure
  final dynamic exception;

  /// Creates an UnknownFailure
  const UnknownFailure({
    required String message,
    this.exception,
    StackTrace? stackTrace,
  }) : super(
          code: 'UNKNOWN_FAILURE',
          message: message,
          stackTrace: stackTrace,
        );

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'exception': exception?.toString(),
      };
}
