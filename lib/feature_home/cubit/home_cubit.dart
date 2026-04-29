import 'package:bloc/bloc.dart';
import '../../../domain/lib/flutter_boilerplate_domain.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

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
