// ignore_for_file: sort_constructors_first

/// Request payload for `POST /login/token.php` on the Moodle web service.
///
/// Moodle's token endpoint expects an `application/x-www-form-urlencoded`
/// body with three fields:
///   * `username`  - the user's Moodle username
///   * `password`  - the user's Moodle password
///   * `service`   - a fixed identifier (`moodle_mobile_app`) that tells the
///                   server which client is requesting the token
///
/// This is a plain (non-Freezed) model because the request is never
/// serialized back to JSON and we want zero codegen overhead for it.
class LoginRequestModel {
  /// Creates a new [LoginRequestModel].
  const LoginRequestModel({
    required this.username,
    required this.password,
  });

  /// Moodle username (sent verbatim, no client-side trimming).
  final String username;

  /// Moodle password (sent verbatim, no client-side trimming).
  final String password;

  /// Fixed `service` value expected by the Moodle web service for mobile
  /// client token requests.
  static const String service = 'moodle_mobile_app';

  /// Encodes the request as an `application/x-www-form-urlencoded` body.
  ///
  /// Both keys and values are percent-encoded via [Uri.encodeQueryComponent]
  /// so that special characters (e.g. `@`, `+`, spaces) in the username or
  /// password survive transport intact.
  String toFormBody() {
    String encode(String key, String value) =>
        '${Uri.encodeQueryComponent(key)}='
        '${Uri.encodeQueryComponent(value)}';

    return [
      encode('username', username),
      encode('password', password),
      encode('service', service),
    ].join('&');
  }
}
