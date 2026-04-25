import '../../repositories/home_repository.dart';
import '../../entities/home_entity.dart';

/// Use case for fetching home data
/// 
/// Encapsulates the business logic for retrieving home screen data.
/// Takes a repository as dependency and returns a [HomeEntity].
class GetHomeDataUseCase {
  final HomeRepository _repository;
  
  const GetHomeDataUseCase(this._repository);
  
  /// Execute the use case
  /// 
  /// [forceRefresh] - If true, bypass cache and fetch from network
  Future<HomeEntity> call({bool forceRefresh = false}) async {
    return await _repository.getHomeData();
  }
}
