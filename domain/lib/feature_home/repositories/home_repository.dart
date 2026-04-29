import '../../../../core/lib/flutter_boilerplate_core.dart';

import '../entities/home_entity.dart';

/// Repository interface for Home feature
///
/// This abstract class defines the contract for data operations
/// that the home feature requires. Implementation details are
/// provided in the data layer.
abstract class HomeRepository {
  /// Get home data from remote or local source
  ///
  /// Returns [Result<HomeEntity>] with data on success or failure on error
  Future<Result<HomeEntity>> getHomeData();

  /// Get detailed home data by ID
  ///
  /// [id] - Unique identifier for the home data item
  /// Returns [Result<HomeEntity>] with data on success or failure on error
  Future<Result<HomeEntity>> getHomeDetail(final String id);

  /// Check if cached data exists and is valid
  Future<bool> hasCachedData();

  /// Clear cached data
  Future<Result<void>> clearCache();

  /// Stream of home data updates (for real-time features)
  ///
  /// Returns a stream of [Result<HomeEntity>] objects
  Stream<Result<HomeEntity>> watchHomeData();
}
