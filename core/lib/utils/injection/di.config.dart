// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:flutter_boilerplate_data/feature_home/datasources/home_remote_datasource.dart'
    as _i8;
import 'package:flutter_boilerplate_data/feature_post/datasources/post_remote_datasource.dart'
    as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../network/api_client.dart' as _i9;
import '../storage/local_storage.dart' as _i10;
import '../storage/shared_prefs_impl.dart' as _i11;
import 'di_module.dart' as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dIModule = _$DIModule();
    await gh.factoryAsync<_i3.Box<String>>(
      () => dIModule.homeBox,
      instanceName: 'home_cache',
      preResolve: true,
    );
    gh.lazySingleton<_i4.Dio>(() => dIModule.dio);
    gh.lazySingleton<_i5.Logger>(() => dIModule.logger);
    await gh.factoryAsync<_i6.SharedPreferences>(
      () => dIModule.prefs,
      preResolve: true,
    );
    gh.factory<String>(
      () => dIModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.lazySingleton<_i9.ApiClient>(() => _i9.ApiClient(
          baseUrl: gh<String>(instanceName: 'baseUrl'),
          dio: gh<_i4.Dio>(),
          connectTimeout: gh<Duration>(),
          receiveTimeout: gh<Duration>(),
          maxRetries: gh<int>(),
        ));
    gh.lazySingleton<_i8.HomeRemoteDatasource>(
        () => dIModule.getHomeRemoteDatasource(
              gh<_i4.Dio>(),
              gh<String>(instanceName: 'baseUrl'),
            ));
    gh.factory<String>(
      () => dIModule.jsonPlaceholderBaseUrl,
      instanceName: 'jsonPlaceholderBaseUrl',
    );
    gh.lazySingleton<_i13.PostRemoteDatasource>(
        () => dIModule.getPostRemoteDatasource(
              gh<_i4.Dio>(),
              gh<String>(instanceName: 'jsonPlaceholderBaseUrl'),
            ));
    gh.lazySingleton<_i10.LocalStorage>(
        () => _i11.SharedPrefsImpl(gh<_i6.SharedPreferences>()));
    return this;
  }
}

class _$DIModule extends _i12.DIModule {}
