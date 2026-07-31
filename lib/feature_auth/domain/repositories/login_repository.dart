import 'package:flutter_boilerplate/feature_auth/domain/entities/login_token_entity.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// Repository contract for the Moodle login feature.
///
/// Defines the operation needed to authenticate a user against the Moodle
/// web-service `POST /login/token.php` endpoint. Implementation lives in the
/// data layer (`data/repositories/login_repository_impl.dart`).
///
/// The contract returns the project's tuple-style [Result] so callers never
/// have to handle exceptions — the repository is responsible for translating
/// transport-level failures (network errors, Moodle's `errorcode` body) into
/// the appropriate [AppFailure] subtype.
abstract class LoginRepository {
  /// Exchanges [username] and [password] for a Moodle web-service token.
  ///
  /// Returns a [Result] whose first element is a populated [LoginTokenEntity]
  /// on success and whose second element is a populated [AppFailure] on
  /// failure (network error, invalid credentials, malformed response, etc.).
  Future<Result<LoginTokenEntity>> login({
    required String username,
    required String password,
  });
}
