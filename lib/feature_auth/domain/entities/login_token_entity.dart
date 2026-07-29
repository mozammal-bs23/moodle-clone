// ignore_for_file: sort_constructors_first
import 'package:flutter/foundation.dart';

/// Immutable representation of a Moodle login token response.
///
/// Returned by `LoginRepository` after a successful authentication against
/// `POST /login/token.php`. This is a pure Dart object with no dependencies
/// on frameworks or transport layers.
@immutable
class LoginTokenEntity {
  /// Creates a new [LoginTokenEntity].
  ///
  /// [token] is the public Moodle web-service token used to authenticate
  /// subsequent requests (sent as the `wstoken` query parameter or via the
  /// `Authorization` header by `AuthInterceptor`).
  ///
  /// [privateToken] is an optional, longer-lived token that can be used to
  /// re-establish a session without re-entering credentials. It is null when
  /// the server omits it.
  const LoginTokenEntity({
    required this.token,
    this.privateToken,
  });

  /// Public Moodle web-service token.
  final String token;

  /// Optional private token for session re-establishment.
  final String? privateToken;

  /// Creates a copy of this entity with the given attributes replaced.
  LoginTokenEntity copyWith({
    String? token,
    String? privateToken,
  }) {
    return LoginTokenEntity(
      token: token ?? this.token,
      privateToken: privateToken ?? this.privateToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginTokenEntity &&
        other.token == token &&
        other.privateToken == privateToken;
  }

  @override
  int get hashCode => Object.hash(token, privateToken);

  @override
  String toString() => 'LoginTokenEntity(token: $token)';
}
