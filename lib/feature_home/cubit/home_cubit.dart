import 'package:bloc/bloc.dart';
import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_cubit.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;

  const factory HomeState.loading() = HomeLoading;

  const factory HomeState.loaded({
    required HomeEntity home,
    required DateTime lastRefresh,
  }) = HomeLoaded;

  const factory HomeState.detailLoading() = HomeDetailLoading;

  const factory HomeState.detailLoaded({
    required HomeEntity detail,
  }) = HomeDetailLoaded;

  const factory HomeState.error({
    required String message,
    @Default(false) bool canRetry,
    String? errorCode,
  }) = HomeError;
}

/// Cubit for managing home screen state
/// 
/// Handles data fetching, loading states, and errors.
@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase _getHomeDataUseCase;
  final GetHomeDetailUseCase _getHomeDetailUseCase;
  
  HomeCubit({
    required GetHomeDataUseCase getHomeDataUseCase,
    required GetHomeDetailUseCase getHomeDetailUseCase,
  })  : _getHomeDataUseCase = getHomeDataUseCase,
        _getHomeDetailUseCase = getHomeDetailUseCase,
        super(const HomeInitial());
  
  /// Fetch home data
  Future<void> fetchHomeData({bool forceRefresh = false}) async {
    emit(const HomeLoading());

    final (data, error) = await _getHomeDataUseCase(forceRefresh: forceRefresh);

    if (data != null) {
      emit(HomeLoaded(
        home: data,
        lastRefresh: DateTime.now(),
      ));
    } else if (error != null) {
      emit(HomeError(
        message: error.message,
        canRetry: true,
      ));
    }
  }

  /// Fetch home detail by ID
  Future<void> fetchHomeDetail(final String id) async {
    emit(const HomeDetailLoading());

    final (data, error) = await _getHomeDetailUseCase(id);

    if (data != null) {
      emit(HomeDetailLoaded(detail: data));
    } else if (error != null) {
      emit(HomeError(
        message: error.message,
        canRetry: true,
      ));
    }
  }
  
  /// Refresh data (force refresh from network)
  Future<void> refresh() async {
    return fetchHomeData(forceRefresh: true);
  }
  
  @override
  Future<void> close() async {
    // Dispose any resources
    await super.close();
  }
}
