import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Interceptor for logging network requests and responses
class LoggingInterceptor extends Interceptor {
  /// Creates a new [LoggingInterceptor]
  LoggingInterceptor({
    Logger? logger,
    this.logRequestBody = true,
    this.logResponseBody = true,
  }) : logger = logger ??
      Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 80,
          printEmojis: false,
        ),
      );

  /// The logger used to print network information
  final Logger logger;

  /// Whether to log the request body
  final bool logRequestBody;

  /// Whether to log the response body
  final bool logResponseBody;

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    final buffer = StringBuffer()
      ..writeln('→ ${options.method.toUpperCase()} ${options.uri}')
      ..writeln('  Headers: ${options.headers}')
      ..writeln('  Query Parameters: ${options.queryParameters}');

    if (logRequestBody && options.data != null) {
      if (options.data is FormData) {
        final formData = options.data as FormData;
        buffer.writeln(
          '  Body: FormData with ${formData.fields.length} fields',
        );
        for (final field in formData.fields) {
          buffer.writeln('    ${field.key}: ${field.value}');
        }
      } else {
        buffer.writeln('  Body: ${options.data}');
      }
    }

    logger.d(buffer.toString());
    handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response,
      ResponseInterceptorHandler handler,
      ) {
    final buffer = StringBuffer()
      ..writeln(
        '← ${response.statusCode} '
            '${response.requestOptions.method.toUpperCase()} '
            '${response.requestOptions.uri}',
      )
      ..writeln('  Headers: ${response.headers.map}');

    if (logResponseBody && response.data != null) {
      buffer.writeln('  Body: ${response.data}');
    }

    logger.d(buffer.toString());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..writeln('✗ Error: ${err.message}')
      ..writeln('  Type: ${err.type}')
      ..writeln(
        '  Request: '
            '${err.requestOptions.method.toUpperCase()} '
            '${err.requestOptions.uri}',
      );

    if (err.response != null) {
      buffer
        ..writeln('  Status Code: ${err.response?.statusCode}')
        ..writeln('  Response: ${err.response?.data}');
    }

    // ✅ FIXED: Pass error and stackTrace as named parameters
    logger.e(
      buffer.toString(),
      error: err,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }
}
