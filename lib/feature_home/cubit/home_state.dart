import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/lib/flutter_boilerplate_domain.dart';

part 'home_state.freezed.dart';

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
