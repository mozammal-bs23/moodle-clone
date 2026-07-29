import 'package:flutter_boilerplate/feature_auth/domain/entities/login_token_entity.dart';
import 'package:flutter_boilerplate/feature_auth/domain/repositories/login_repository.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// Use case for authenticating a user against the Moodle login endpoint.
///
/// Thin pass-through to [LoginRepository.login]; the separation exists so
/// presentation-layer code (e.g. `LoginCubit`) depends on a stable use-case
/// surface rather than the repository contract, leaving room for future
/// cross-cutting concerns (rate limiting, credential validation, audit
/// logging) to be added here without touching the data layer.
///
/// Registered as a factory in `lib/src/injection/di.dart` rather than via
/// `@injectable` to keep all cross-layer wiring for the auth feature in one
/// place.
class LoginUseCase {
  /// Creates a new [LoginUseCase].
  const LoginUseCase(this._repository);

  final LoginRepository _repository;

  /// Execute the use case.
  ///
  /// [username] and [password] are forwarded to the repository unchanged —
  /// any client-side validation belongs in the presentation layer (e.g. the
  /// `LoginForm` should already prevent empty submissions).
  Future<Result<LoginTokenEntity>> call({
    required String username,
    required String password,
  }) =>
      _repository.login(username: username, password: password);
}
