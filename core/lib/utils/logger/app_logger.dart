import 'dart:convert';
import 'package:logger/logger.dart';

/// Application logger configuration.
/// Centralized logging utility for the app.
class AppLogger {
  /// Private constructor to prevent instantiation.
  AppLogger._();

  /// Internal logger instance.
  static late Logger _logger;

  /// Flag to enable or disable logging.
  static bool _isEnabled = true;

  /// Initializes the logger with custom configuration.
  ///
  /// [level] sets the logging threshold level.
  /// [enable] controls whether logging is active.
  /// [customLogger] allows passing a custom [Logger] instance.
  static void init({
    Level level = Level.debug,
    bool enable = true,
    Logger? customLogger,
  }) {
    _isEnabled = enable;

    _logger = customLogger ??
        Logger(
          printer: PrettyPrinter(
            methodCount: 0,
            errorMethodCount: 5,
            lineLength: 80,
            printEmojis: false,
          ),
        );
  }

  /// Logs a trace/verbose message.
  ///
  /// Accepts optional [error] and [stackTrace].
  static void t(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.v(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Logs a debug message.
  ///
  /// Accepts optional [error] and [stackTrace].
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.d(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Logs an info message.
  ///
  /// Accepts optional [error] and [stackTrace].
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.i(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Logs a warning message.
  ///
  /// Accepts optional [error] and [stackTrace].
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.w(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Logs an error message.
  ///
  /// Accepts optional [error] and [stackTrace].
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.e(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Logs a fatal/wtf message.
  ///
  /// Accepts optional [error] and [stackTrace].
  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_isEnabled) {
      _logger.wtf(
        message,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Logs an object instance with an optional [name].
  static void logObject(Object object, {String? name}) {
    if (_isEnabled) {
      _logger.i('${name ?? 'Object'}: $object');
    }
  }

  /// Logs a JSON map formatted with proper indentation.
  ///
  /// Accepts a [json] map and an optional header [name].
  static void logJson(Map<String, dynamic> json, {String? name}) {
    if (_isEnabled) {
      const encoder = JsonEncoder.withIndent('  ');
      _logger.i('${name ?? 'JSON'}:\n${encoder.convert(json)}');
    }
  }

  /// Logs an HTTP API request details.
  ///
  /// Accepts HTTP [method], target [url], optional [headers], and [body].
  static void logRequest({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    if (_isEnabled) {
      final buffer = StringBuffer()
        ..writeln('→ $method $url')
        ..writeln('Headers: $headers');

      if (body != null) {
        buffer.writeln('Body: $body');
      }

      _logger.d(buffer.toString());
    }
  }

  /// Logs an HTTP API response details.
  ///
  /// Accepts [statusCode], target [url], and response [data].
  static void logResponse({
    required int statusCode,
    required String url,
    dynamic data,
  }) {
    if (_isEnabled) {
      _logger.d('← $statusCode $url\nResponse: $data');
    }
  }

  /// Disables all output logging.
  static void disable() {
    _isEnabled = false;
  }

  /// Enables output logging.
  static void enable() {
    _isEnabled = true;
  }

  /// Toggles the output logging state.
  static void toggle() {
    _isEnabled = !_isEnabled;
  }
}