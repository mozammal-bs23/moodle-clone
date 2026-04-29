import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';

@module
abstract class DIModule {
  @Named('baseUrl')
  String get baseUrl => AppConstants.baseUrl;

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

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dio => Dio();

  @preResolve
  @Named('home_cache')
  Future<Box<String>> get homeBox => Hive.openBox<String>('home_cache');

  @lazySingleton
  HomeRemoteDatasource getHomeRemoteDatasource(Dio dio, @Named('baseUrl') String baseUrl) => 
      HomeRemoteDatasource(dio, baseUrl: baseUrl);
}
