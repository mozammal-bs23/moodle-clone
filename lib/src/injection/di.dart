/// Dependency Injection Setup
///
/// Layers app, domain, and data registrations on top of the core package's
/// generated config. The injectable generator cannot see annotations across
/// package boundaries, so these cross-package registrations are wired
/// manually here.
library;

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/feature_my_courses/cubit/course_contents_cubit.dart';
import 'package:flutter_boilerplate/feature_my_courses/cubit/my_courses_cubit.dart';
import 'package:flutter_boilerplate/feature_post/cubit/post_cubit.dart';
import 'package:flutter_boilerplate_core/utils/injection/di.dart' as core_di;
import 'package:flutter_boilerplate_core/utils/storage/local_storage.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/datasources/course_categories_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/datasources/course_contents_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/datasources/my_courses_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/repositories/course_categories_repository_impl.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/repositories/course_contents_repository_impl.dart';
import 'package:flutter_boilerplate_data/feature_my_courses/repositories/my_courses_repository_impl.dart';
import 'package:flutter_boilerplate_data/feature_post/datasources/post_remote_datasource.dart';
import 'package:flutter_boilerplate_data/feature_post/repositories/post_repository_impl.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:get_it/get_it.dart';

export 'package:flutter_boilerplate_core/utils/injection/di.dart'
    hide configureDependencies;

/// Global service locator instance
final GetIt getIt = core_di.getIt;

/// Main entry point for configuring dependencies
///
/// Call this function in `main()` before `runApp()`
Future<void> configureDependencies([String? environment]) async {
  await core_di.configureDependencies(environment);

  getIt
    ..registerSingleton<String>(
      'https://lmsmobile.ahnafmuttaki.com/webservice/rest/server.php',
      instanceName: 'moodleBaseUrl',
    )
    ..registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(
        remoteDatasource: getIt<PostRemoteDatasource>(),
      ),
    )
    ..registerFactory<GetPostsUseCase>(
      () => GetPostsUseCase(getIt<PostRepository>()),
    )
    ..registerFactory<GetPostUseCase>(
      () => GetPostUseCase(getIt<PostRepository>()),
    )
    ..registerFactory<CreatePostUseCase>(
      () => CreatePostUseCase(getIt<PostRepository>()),
    )
    ..registerFactory<UpdatePostUseCase>(
      () => UpdatePostUseCase(getIt<PostRepository>()),
    )
    ..registerFactory<PatchPostUseCase>(
      () => PatchPostUseCase(getIt<PostRepository>()),
    )
    ..registerFactory<DeletePostUseCase>(
      () => DeletePostUseCase(getIt<PostRepository>()),
    )
    ..registerFactory<PostCubit>(
      () => PostCubit(
        getPostsUseCase: getIt<GetPostsUseCase>(),
        createPostUseCase: getIt<CreatePostUseCase>(),
        updatePostUseCase: getIt<UpdatePostUseCase>(),
        patchPostUseCase: getIt<PatchPostUseCase>(),
        deletePostUseCase: getIt<DeletePostUseCase>(),
      ),
    )

    // ---- Feature: My Courses ----
    // The injectable generator cannot see @LazySingleton annotations
    // across package boundaries, so we wire the data layer up manually
    // here — same pattern as PostRepository above.
    ..registerLazySingleton<MyCoursesRemoteDatasource>(
      () => MyCoursesRemoteDatasource(
        getIt<Dio>(),
        baseUrl: getIt<String>(instanceName: 'moodleBaseUrl'),
      ),
    )
    ..registerLazySingleton<MyCoursesRepository>(
      () => MyCoursesRepositoryImpl(
        remoteDatasource: getIt<MyCoursesRemoteDatasource>(),
      ),
    )
    ..registerFactory<GetMyCoursesUseCase>(
      () => GetMyCoursesUseCase(
        getIt<MyCoursesRepository>(),
        getIt<LocalStorage>(),
      ),
    )
    ..registerFactory<MyCoursesCubit>(
      () => MyCoursesCubit(
        getMyCoursesUseCase: getIt<GetMyCoursesUseCase>(),
        getCourseCategoriesUseCase: getIt<GetCourseCategoriesUseCase>(),
      ),
    )

    // Course categories: same wiring pattern as the MyCourses block
    // above. The data layer's @LazySingleton annotations don't get
    // scanned across packages, so we register the datasource +
    // repository here too.
    ..registerLazySingleton<CourseCategoriesRemoteDatasource>(
      () => CourseCategoriesRemoteDatasource(
        getIt<Dio>(),
        baseUrl: getIt<String>(instanceName: 'moodleBaseUrl'),
      ),
    )
    ..registerLazySingleton<CourseCategoriesRepository>(
      () => CourseCategoriesRepositoryImpl(
        remoteDatasource: getIt<CourseCategoriesRemoteDatasource>(),
      ),
    )
    ..registerFactory<GetCourseCategoriesUseCase>(
      () => GetCourseCategoriesUseCase(
        getIt<CourseCategoriesRepository>(),
        getIt<LocalStorage>(),
      ),
    )

    // Course contents: same wiring pattern as the MyCourses block
    // above. The data layer's @LazySingleton annotations don't get
    // scanned across packages, so we register the datasource +
    // repository here too.
    ..registerLazySingleton<CourseContentsRemoteDatasource>(
      () => CourseContentsRemoteDatasource(
        getIt<Dio>(),
        baseUrl: getIt<String>(instanceName: 'moodleBaseUrl'),
      ),
    )
    ..registerLazySingleton<CourseContentsRepository>(
      () => CourseContentsRepositoryImpl(
        remoteDatasource: getIt<CourseContentsRemoteDatasource>(),
        localStorage: getIt<LocalStorage>(),
      ),
    )
    ..registerFactory<GetCourseContentsUseCase>(
      () =>
          GetCourseContentsUseCase(getIt<CourseContentsRepository>()),
    )
    ..registerFactory<CourseContentsCubit>(
      () => CourseContentsCubit(
        getCourseContentsUseCase: getIt<GetCourseContentsUseCase>(),
        localStorage: getIt<LocalStorage>(),
      ),
    );
}
