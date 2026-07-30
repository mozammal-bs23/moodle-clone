import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_boilerplate/feature_qr_scan/cubit/qr_scan_state.dart';
import 'package:flutter_boilerplate/feature_qr_scan/utils/qr_url_parser.dart';

/// Drives the QR scanner page.
///
/// Responsibilities:
///   * Track torch + front/back-camera selection.
///   * Resolve camera permission and emit [QrScanStatus.permissionDenied]
///     when the user has blocked us.
///   * Receive raw scan events from the camera controller and decide
///     whether to accept the payload (extracts a base URL via
///     [extractBaseUrl]).
class QrScanCubit extends Cubit<QrScanState> {
  QrScanCubit() : super(const QrScanState());

  /// Direct handle to the underlying camera controller. The page holds
  /// this read-only via [cameraController] and feeds detections back
  /// through [onDetect].
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 500,
  );

  /// True after the first scan so we ignore repeated detections of the
  /// same code while the navigation animation plays out.
  bool _settled = false;

  /// Public read-only access to the camera controller for the view layer.
  MobileScannerController get cameraController => controller;

  /// Called from the page once mounted. Requests camera permission and
  /// transitions the state into either [QrScanStatus.scanning] or
  /// [QrScanStatus.permissionDenied] / [QrScanStatus.cameraError].
  Future<void> initialize() async {
    final status = await Permission.camera.request();
    if (status.isPermanentlyDenied) {
      emit(state.copyWith(status: QrScanStatus.permissionDenied));
      return;
    }
    if (!status.isGranted) {
      emit(state.copyWith(status: QrScanStatus.permissionDenied));
      return;
    }
    try {
      await controller.start();
      emit(state.copyWith(status: QrScanStatus.scanning));
    } catch (_) {
      emit(state.copyWith(status: QrScanStatus.cameraError));
    }
  }

  /// Toggle the torch on/off.
  Future<void> toggleTorch() async {
    final next = !state.torchEnabled;
    await controller.toggleTorch();
    emit(state.copyWith(torchEnabled: next));
  }

  /// Switch between front and rear camera.
  Future<void> switchCamera() async {
    await controller.switchCamera();
    emit(state.copyWith(usingFrontCamera: !state.usingFrontCamera));
  }

  /// Called by the page when [MobileScanner] emits a fresh detection.
  ///
  /// Returns the parsed URL when the scan is acceptable so the page can
  /// pop the route with it. Returns `null` if we already accepted a code,
  /// or if the payload is not a usable URL (in which case we surface an
  /// error via [state] and resume scanning).
  String? onDetect(BarcodeCapture capture) {
    if (_settled) return null;
    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue;
      if (raw == null || raw.isEmpty) continue;
      final parsed = extractBaseUrl(raw);
      if (parsed == null) {
        emit(state.copyWith(
          status: QrScanStatus.scanning,
          lastRawValue: raw,
          errorMessage: 'invalid',
        ));
        return null;
      }
      _settled = true;
      // Pause the camera while the result overlay is on screen so we
      // do not keep firing scans for the same code.
      unawaitedSafe(controller.stop());
      emit(state.copyWith(
        status: QrScanStatus.detected,
        lastRawValue: raw,
        parsedUrl: parsed,
        clearError: true,
      ));
      return parsed;
    }
    return null;
  }

  /// Reset the "we already accepted a scan" latch so the user can rescan
  /// after an invalid detection, after dismissing the result overlay, or
  /// after returning from a denied permission flow.
  Future<void> resumeScanning() async {
    _settled = false;
    emit(state.copyWith(
      status: QrScanStatus.scanning,
      clearError: true,
      clearLastValue: true,
      clearParsedUrl: true,
    ));
    await controller.start();
  }

  /// Clear the transient error message (used after the snackbar dismisses).
  void clearError() {
    if (state.errorMessage == null) return;
    emit(state.copyWith(clearError: true));
  }

  @override
  Future<void> close() async {
    await controller.dispose();
    return super.close();
  }
}

/// Tiny helper that mirrors Dart's `unawaited` without the `dart:async`
/// import noise. The camera pause/restart calls are fire-and-forget from
/// the cubit's perspective; surfacing them as unawaited keeps the analyzer
/// happy without changing observable behavior.
void unawaitedSafe(Future<void> future) {
  future.then((_) {}, onError: (_) {});
}