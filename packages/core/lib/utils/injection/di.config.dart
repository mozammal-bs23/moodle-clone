// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i11;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../features/home/data/datasources/home_remote_datasource.dart'
    as _i8;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i10;
import '../../features/home/domain/repositories/home_repository.dart' as _i9;
import '../../features/home/domain/usecases/get_home_data_usecase.dart' as _i14;
import '../../features/home/domain/usecases/get_home_detail_usecase.dart'
    as _i15;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i16;
import '../network/api_client.dart' as _i7;
import '../storage/local_storage.dart' as _i12;
import '../storage/shared_prefs_impl.dart' as _i13;
import 'di_module.dart' as _i17;

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
    gh.lazySingleton<_i7.ApiClient>(() => _i7.ApiClient(
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
    gh.lazySingleton<_i9.HomeRepository>(() => _i10.HomeRepositoryImpl(
          remoteDatasource: gh<_i8.HomeRemoteDatasource>(),
          cacheBox: gh<_i11.Box<String>>(instanceName: 'home_cache'),
        ));
    gh.lazySingleton<_i12.LocalStorage>(
        () => _i13.SharedPrefsImpl(gh<_i6.SharedPreferences>()));
    gh.factory<_i14.GetHomeDataUseCase>(
        () => _i14.GetHomeDataUseCase(gh<_i9.HomeRepository>()));
    gh.factory<_i15.GetHomeDetailUseCase>(
        () => _i15.GetHomeDetailUseCase(gh<_i9.HomeRepository>()));
    gh.factory<_i16.HomeCubit>(() => _i16.HomeCubit(
          getHomeDataUseCase: gh<_i14.GetHomeDataUseCase>(),
          getHomeDetailUseCase: gh<_i15.GetHomeDetailUseCase>(),
        ));
    return this;
  }
}

class _$DIModule extends _i17.DIModule {}
