// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

/// Data model for the Moodle `POST /login/token.php` response.
///
/// Moodle returns HTTP 200 for both success and failure — the discriminator
/// lives in the JSON body:
///   * Success: `{"token": "...", "privatetoken": "..."}`
///   * Failure: `{"error": "...", "errorcode": "...", "stacktrace": ...}`
///
/// All fields are therefore nullable so the same model can parse either
/// shape. The repository inspects [error] / [errorcode] to decide which
/// `Result` variant to produce.
@freezed
class LoginResponseModel with _$LoginResponseModel {
  /// Creates a [LoginResponseModel].
  const factory LoginResponseModel({
    /// Public web-service token (populated on success).
    String? token,

    /// Optional private token for session re-establishment.
    String? privatetoken,

    /// Human-readable error message (populated on failure).
    String? error,

    /// Machine-readable error code, e.g. `invalidlogin` (populated on
    /// failure).
    String? errorcode,

    /// Stack trace (populated only in debug builds on failure).
    String? stacktrace,

    /// Debug info (populated only in debug builds on failure).
    String? debuginfo,

    /// Reproduction link (populated only in debug builds on failure).
    String? reproductionlink,
  }) = _LoginResponseModel;

  /// Creates a [LoginResponseModel] from a JSON map.
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}
