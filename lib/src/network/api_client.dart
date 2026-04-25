import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../failure/app_failure.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'result.dart';

/// HTTP client implementation using Dio
/// Handles all network operations with proper error handling
class ApiClient {
  /// Dio instance
  final Dio _dio;

  /// Base URL for API endpoints
  final String baseUrl;

  /// Connection timeout duration
  final Duration connectTimeout;

  /// Receive timeout duration
  final Duration receiveTimeout;

  /// Maximum number of retries for failed requests
  final int maxRetries;

  /// Creates an [ApiClient]
  ApiClient({
    required this.baseUrl,
    Dio? dio,
    this.connectTimeout = const Duration(seconds: 30),
    this.receiveTimeout = const Duration(seconds: 30),
    this.maxRetries = 3,
  }) : _dio = dio ?? Dio() {
    _setupDio();
  }

  /// Configures Dio with interceptors and options
  void _setupDio() {
    _dio
      ..options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      )
      ..interceptors.add(
        LoggingInterceptor(
          logRequestBody: !kReleaseMode,
          logResponseBody: !kReleaseMode,
        ),
      );
  }

  /// Adds authentication interceptor to the client
  void addAuthInterceptor({
    required Future<String?> Function() getToken,
    Future<String?> Function()? refreshToken,
  }) {
    _dio.interceptors.add(
      AuthInterceptor(
        getToken: getToken,
        refreshToken: refreshToken,
      ),
    );
  }

  /// Adds a custom interceptor
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// Performs a GET request
  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return Result.success(response.data);
    } on DioError catch (e) {
      return Result.failure(_mapError(e));
    } catch (e, stackTrace) {
      return Result.failure(
        UnknownFailure(
          message: e.toString(),
          exception: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Performs a POST request
  Future<Result<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Result.success(response.data);
    } on DioError catch (e) {
      return Result.failure(_mapError(e));
    } catch (e, stackTrace) {
      return Result.failure(
        UnknownFailure(
          message: e.toString(),
          exception: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Performs a PUT request
  Future<Result<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Result.success(response.data);
    } on DioError catch (e) {
      return Result.failure(_mapError(e));
    } catch (e, stackTrace) {
      return Result.failure(
        UnknownFailure(
          message: e.toString(),
          exception: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Performs a PATCH request
  Future<Result<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Result.success(response.data);
    } on DioError catch (e) {
      return Result.failure(_mapError(e));
    } catch (e, stackTrace) {
      return Result.failure(
        UnknownFailure(
          message: e.toString(),
          exception: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Performs a DELETE request
  Future<Result<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return Result.success(response.data);
    } on DioError catch (e) {
      return Result.failure(_mapError(e));
    } catch (e, stackTrace) {
      return Result.failure(
        UnknownFailure(
          message: e.toString(),
          exception: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Performs a multipart upload
  Future<Result<T>> upload<T>(
    String path,
    FormData formData, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
      );
      return Result.success(response.data);
    } on DioError catch (e) {
      return Result.failure(_mapError(e));
    } catch (e, stackTrace) {
      return Result.failure(
        UnknownFailure(
          message: e.toString(),
          exception: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Downloads a file
  Future<Result<String>> download(
    String url,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
      );
      return Result.success(savePath);
    } on DioError catch (e) {
      return Result.failure(_mapError(e));
    } catch (e, stackTrace) {
      return Result.failure(
        UnknownFailure(
          message: e.toString(),
          exception: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  /// Maps a DioError to an AppFailure
  AppFailure _mapError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return NetworkFailure(
          message: AppStrings.errorTimeout,
          stackTrace: error.stackTrace,
        );

      case DioErrorType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        final responseBody = error.response?.data?.toString();
        
        switch (statusCode) {
          case 400:
            return NetworkFailure(
              message: AppStrings.errorBadRequest,
              statusCode: statusCode,
              responseBody: responseBody,
              stackTrace: error.stackTrace,
            );
          case 401:
            return NetworkFailure(
              message: AppStrings.errorUnauthorized,
              statusCode: statusCode,
              responseBody: responseBody,
              stackTrace: error.stackTrace,
            );
          case 403:
            return NetworkFailure(
              message: 'Forbidden',
              statusCode: statusCode,
              responseBody: responseBody,
              stackTrace: error.stackTrace,
            );
          case 404:
            return NetworkFailure(
              message: 'Not found',
              statusCode: statusCode,
              responseBody: responseBody,
              stackTrace: error.stackTrace,
            );
          case 500:
          case 502:
          case 503:
          case 504:
            return NetworkFailure(
              message: AppStrings.errorServer,
              statusCode: statusCode,
              responseBody: responseBody,
              stackTrace: error.stackTrace,
            );
          default:
            return NetworkFailure(
              message: 'HTTP Error: $statusCode',
              statusCode: statusCode,
              responseBody: responseBody,
              stackTrace: error.stackTrace,
            );
        }

      case DioErrorType.cancel:
        return NetworkFailure(
          message: 'Request cancelled',
          stackTrace: error.stackTrace,
        );

      case DioErrorType.connectionError:
        return NetworkFailure(
          message: AppStrings.errorNetwork,
          stackTrace: error.stackTrace,
        );

      case DioErrorType.badCertificate:
        return NetworkFailure(
          message: 'Bad certificate',
          stackTrace: error.stackTrace,
        );

      case DioErrorType.unknown:
        return NetworkFailure(
          message: AppStrings.errorGeneral,
          stackTrace: error.stackTrace,
        );
    }
  }

  /// Returns the underlying Dio instance for advanced usage
  Dio get dio => _dio;

  /// Closes the dio client
  void close() {
    _dio.close();
  }
}
