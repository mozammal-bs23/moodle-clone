import 'package:dio/dio.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_data/feature_post/datasources/post_remote_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// DI Module for core dependencies
@module
abstract class DIModule {
  /// Base URL for API calls
  @Named('baseUrl')
  String get baseUrl => FlavorConfig.instance.baseUrl;

  /// Dio client configuration
  @lazySingleton
  Logger get logger => Logger(
        level: Level.debug,
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 80,
          printEmojis: false,
        ),
      );

  /// Shared Preferences instance
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  /// Dio client configuration
  ///
  /// Sets a default JSON content-type so requests with a body (POST/PUT/
  /// PATCH) are sent as `application/json` even when [ApiClient] - which
  /// otherwise configures this same shared instance - hasn't been
  /// instantiated yet by anything else in the dependency graph.
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(contentType: 'application/json; charset=UTF-8'),
      );

  /// Default connection timeout
  @lazySingleton
  Duration get connectTimeout => const Duration(seconds: 30);

  /// Default receive timeout (reusing connectTimeout's value for simplicity)
  @Named('receiveTimeout')
  Duration get receiveTimeout => const Duration(seconds: 30);

  /// Default retry count
  @lazySingleton
  int get maxRetries => 3;

  /// Base URL for the JSONPlaceholder demo API (feature_post only)
  @Named('jsonPlaceholderBaseUrl')
  String get jsonPlaceholderBaseUrl => 'https://jsonplaceholder.typicode.com';

  /// Post remote datasource
  @lazySingleton
  PostRemoteDatasource getPostRemoteDatasource(
    Dio dio,
    @Named('jsonPlaceholderBaseUrl') String baseUrl,
  ) =>
      PostRemoteDatasource(dio, baseUrl: baseUrl);
}
