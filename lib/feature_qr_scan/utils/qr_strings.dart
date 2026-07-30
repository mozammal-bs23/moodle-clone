/// Screen-local string constants for the QR scanner feature.
///
/// Kept inside the feature so PRs remain `lib/`-only and so this page can
/// evolve its own copy independently of the shared `AppStrings`.
class QrStrings {
  const QrStrings._();

  /// App bar title shown at the top of the scanner screen.
  static const String title = 'Scan QR code';

  /// Tooltip / accessibility label for the close button.
  static const String closeTooltip = 'Close';

  /// Tooltip for the torch / flash toggle button.
  static const String torchOnTooltip = 'Turn off flash';
  static const String torchOffTooltip = 'Turn on flash';

  /// Tooltip for the front/back camera switch.
  static const String switchCameraTooltip = 'Switch camera';

  /// Shown when the user has not granted camera permission.
  static const String permissionTitle = 'Camera access required';
  static const String permissionBody =
      'To scan a QR code, please grant camera access.';
  static const String permissionOpenSettings = 'Open settings';
  static const String permissionRetry = 'Try again';

  /// Shown when the camera fails to initialize.
  static const String cameraErrorTitle = 'Camera unavailable';
  static const String cameraErrorBody =
      'We could not start the camera. Please try again.';
  static const String cameraRetry = 'Retry';

  /// Snackbar message shown when the scanned value is not a usable URL.
  static const String invalidQrTitle = 'Invalid QR code';
  static const String invalidQrBody =
      'The scanned QR code does not look like a Moodle site URL.';
}