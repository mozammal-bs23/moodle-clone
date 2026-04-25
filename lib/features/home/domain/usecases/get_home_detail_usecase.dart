import '../../repositories/home_repository.dart';
import '../../entities/home_entity.dart';

/// Use case for fetching home detail by ID
/// 
/// Encapsulates the business logic for retrieving detailed
/// information about a specific home item.
class GetHomeDetailUseCase {
  final HomeRepository _repository;
  
  const GetHomeDetailUseCase(this._repository);
  
  /// Execute the use case
  /// 
  /// [id] - Unique identifier for the item
  Future<HomeEntity> call(String id) async {
    return await _repository.getHomeDetail(id);
  }
}
