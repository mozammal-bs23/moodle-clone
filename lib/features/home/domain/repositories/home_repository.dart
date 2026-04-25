/// Repository interface for Home feature
/// 
/// This abstract class defines the contract for data operations
/// that the home feature requires. Implementation details are
/// provided in the data layer.
abstract class HomeRepository {
  /// Get home data from remote or local source
  /// 
  /// Returns [HomeEntity] on success
  /// Throws [Exception] on failure
  Future<HomeEntity> getHomeData();
  
  /// Get detailed home data by ID
  /// 
  /// [id] - Unique identifier for the home data item
  /// Returns [HomeEntity] on success
  /// Throws [Exception] on failure
  Future<HomeEntity> getHomeDetail(String id);
  
  /// Check if cached data exists and is valid
  Future<bool> hasCachedData();
  
  /// Clear cached data
  Future<void> clearCache();
  
  /// Stream of home data updates (for real-time features)
  /// 
  /// Returns a stream of [HomeEntity] objects
  Stream<HomeEntity> watchHomeData();
}
