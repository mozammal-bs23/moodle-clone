import 'package:equatable/equatable.dart';

/// Top-level status of the QR scanner page.
enum QrScanStatus {
  /// Initial state — we have not asked for camera permission yet.
  initial,

  /// Permission was denied or is restricted.
  permissionDenied,

  /// Camera failed to start (hardware error, etc.).
  cameraError,

  /// Camera is up and we are waiting for a code.
  scanning,

  /// A code was detected; the result overlay is visible.
  detected,
}

/// Immutable state for [QrScanCubit].
class QrScanState extends Equatable {
  const QrScanState({
    this.status = QrScanStatus.initial,
    this.torchEnabled = false,
    this.usingFrontCamera = false,
    this.lastRawValue,
    this.errorMessage,
    this.parsedUrl,
  });

  /// Current status of the scanner.
  final QrScanStatus status;

  /// Whether the torch / flash is currently on.
  final bool torchEnabled;

  /// Whether the front camera is being used (vs. the rear camera).
  final bool usingFrontCamera;

  /// Most recent raw value scanned, kept for diagnostics / retry UI.
  final String? lastRawValue;

  /// Optional human-readable error message (used for the snackbar).
  final String? errorMessage;

  /// The parsed, normalized base URL extracted from the most recent
  /// successful scan. Non-null while the result overlay is shown.
  final String? parsedUrl;

  QrScanState copyWith({
    QrScanStatus? status,
    bool? torchEnabled,
    bool? usingFrontCamera,
    String? lastRawValue,
    String? errorMessage,
    String? parsedUrl,
    bool clearError = false,
    bool clearLastValue = false,
    bool clearParsedUrl = false,
  }) {
    return QrScanState(
      status: status ?? this.status,
      torchEnabled: torchEnabled ?? this.torchEnabled,
      usingFrontCamera: usingFrontCamera ?? this.usingFrontCamera,
      lastRawValue:
          clearLastValue ? null : (lastRawValue ?? this.lastRawValue),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      parsedUrl: clearParsedUrl ? null : (parsedUrl ?? this.parsedUrl),
    );
  }

  @override
  List<Object?> get props => [
        status,
        torchEnabled,
        usingFrontCamera,
        lastRawValue,
        errorMessage,
        parsedUrl,
      ];
}