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

  /// Logger configuration
  @lazySingleton
  Logger get logger => Logger(
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
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(contentType: 'application/json; charset=UTF-8'),
      );

  /// Default network timeouts and retries
  @factoryMethod
  Duration get timeout => const Duration(seconds: 30);
  
  @factoryMethod
  int get maxRetries => 3;

  /// Base URL for the JSONPlaceholder demo API
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
