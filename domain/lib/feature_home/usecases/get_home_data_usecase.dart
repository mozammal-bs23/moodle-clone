import '../../../../core/lib/flutter_boilerplate_core.dart';
import 'package:injectable/injectable.dart';

import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

/// Use case for fetching home data
///
/// Encapsulates the business logic for retrieving home screen data.
/// Takes a repository as dependency and returns a [Result<HomeEntity>].
@injectable
class GetHomeDataUseCase {
  const GetHomeDataUseCase(this._repository);

  final HomeRepository _repository;

  /// Execute the use case
  ///
  /// [forceRefresh] - If true, bypass cache and fetch from network
  Future<Result<HomeEntity>> call({final bool forceRefresh = false}) async {
    return await _repository.getHomeData();
  }
}
