import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_boilerplate_domain/feature_home/entities/home_entity.dart';
import 'package:flutter_boilerplate_domain/feature_home/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

/// Use case for fetching home data
///
/// Encapsulates the business logic for retrieving home screen data.
/// Takes a repository as dependency and returns a [Result<HomeEntity>].
@injectable
class GetHomeDataUseCase {
  /// Creates a new instance of GetHomeDataUseCase
  const GetHomeDataUseCase(this._repository);

  final HomeRepository _repository;

  /// Execute the use case
  ///
  /// [forceRefresh] - If true, bypass cache and fetch from network
  Future<Result<HomeEntity>> call({bool forceRefresh = false}) =>
      _repository.getHomeData();
}
