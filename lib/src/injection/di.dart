import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';
import '../network/api_client.dart';
import '../storage/local_storage.dart';
import '../storage/shared_prefs_impl.dart';

// Home feature imports
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_data_usecase.dart';
import '../../features/home/domain/usecases/get_home_detail_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';

import 'di.config.dart'; // Generated code will be added here

/// Global service locator instance
final GetIt sl = GetIt.instance;

/// Main entry point for configuring dependencies
/// 
/// Call this function in `main()` before `runApp()`
@InjectableInit()
Future<void> configureDependencies([String? environment]) async {
  // Initialize core services manually
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Register Hive boxes
  final homeBox = await Hive.openBox<String>('home_cache');
  final prefs = await SharedPreferences.getInstance();
  
  // Register LocalStorage
  sl.registerSingleton<LocalStorage>(SharedPrefsImpl(prefs));
  
  // Register Hive Box for home cache
  sl.registerSingleton<Box<String>>(homeBox);

  // Register Logger
  sl.registerLazySingleton<Logger>(() => Logger(
        level: Level.debug,
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 80,
          colors: true,
          printEmojis: false,
        ),
      ));

  // Register ApiClient
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: AppConstants.connectionTimeout),
      receiveTimeout: const Duration(seconds: AppConstants.receiveTimeout),
    ),
  );

  // Register Home feature dependencies
  // Home Remote Datasource
  sl.registerFactory<HomeRemoteDatasource>(
    () => HomeRemoteDatasource(
      sl<ApiClient>().dio,
      baseUrl: AppConstants.baseUrl,
    ),
  );
  
  // Home Repository
  sl.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDatasource: sl<HomeRemoteDatasource>(),
      cacheBox: sl<Box<String>>(),
    ),
  );
  
  // Home Use Cases
  sl.registerFactory<GetHomeDataUseCase>(
    () => GetHomeDataUseCase(sl<HomeRepository>()),
  );
  sl.registerFactory<GetHomeDetailUseCase>(
    () => GetHomeDetailUseCase(sl<HomeRepository>()),
  );
  
  // Home Cubit
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(
      getHomeDataUseCase: sl<GetHomeDataUseCase>(),
      getHomeDetailUseCase: sl<GetHomeDetailUseCase>(),
    ),
  );

  // Let injectable generate registrations for other dependencies
  await $initGetIt(sl, environment: environment);
}
