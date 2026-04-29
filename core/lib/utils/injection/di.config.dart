// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import 'package:dio/dio.dart' as _i5;
import 'package:hive/hive.dart' as _i6;

import 'di_module.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final diModule = _$DIModule();
    gh.lazySingleton<_i3.Logger>(() => diModule.logger);
    gh.lazySingleton<_i5.Dio>(() => diModule.dio);
    return this;
  }
}

class _$DIModule extends _i7.DIModule {}
