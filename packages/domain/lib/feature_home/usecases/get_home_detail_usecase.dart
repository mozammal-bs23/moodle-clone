import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:injectable/injectable.dart';

import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

/// Use case for fetching home detail by ID
///
/// Encapsulates the business logic for retrieving detailed
/// information about a specific home item.
@injectable
class GetHomeDetailUseCase {
  const GetHomeDetailUseCase(this._repository);

  final HomeRepository _repository;

  /// Execute the use case
  ///
  /// [id] - Unique identifier for the item
  Future<Result<HomeEntity>> call(final String id) async {
    return await _repository.getHomeDetail(id);
  }
}
