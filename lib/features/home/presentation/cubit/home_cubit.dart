import 'package:bloc/bloc.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import '../../domain/usecases/get_home_detail_usecase.dart';

part 'home_state.dart';

/// Cubit for managing home screen state
/// 
/// Handles data fetching, loading states, and errors.
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
    
    try {
      final result = await _getHomeDataUseCase(forceRefresh: forceRefresh);
      emit(HomeLoaded(
        home: result,
        lastRefresh: DateTime.now(),
      ));
    } catch (e) {
      emit(HomeError(
        message: e.toString(),
        canRetry: true,
      ));
    }
  }
  
  /// Fetch home detail by ID
  Future<void> fetchHomeDetail(String id) async {
    emit(const HomeDetailLoading());
    
    try {
      final result = await _getHomeDetailUseCase(id);
      emit(HomeDetailLoaded(detail: result));
    } catch (e) {
      emit(HomeError(
        message: e.toString(),
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
