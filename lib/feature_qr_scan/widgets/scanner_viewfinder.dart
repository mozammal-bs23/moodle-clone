import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Thin wrapper around [MobileScanner] that wires the camera controller
/// into the page's cubit via [onDetect] and paints a placeholder view
/// when the camera fails to start.
class ScannerViewfinder extends StatelessWidget {
  const ScannerViewfinder({
    required this.controller,
    required this.onDetect,
    required this.overlay,
    super.key,
  });

  /// Owning camera controller from [QrScanCubit].
  final MobileScannerController controller;

  /// Callback invoked when a barcode is detected.
  final void Function(BarcodeCapture capture) onDetect;

  /// Overlay to paint on top of the camera preview.
  final Widget overlay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        MobileScanner(
          controller: controller,
          onDetect: onDetect,
          errorBuilder: (context, error, child) {
            return _CameraErrorView(message: error.errorDetails?.message);
          },
          fit: BoxFit.cover,
        ),
        Positioned.fill(child: overlay),
      ],
    );
  }
}

class _CameraErrorView extends StatelessWidget {
  const _CameraErrorView({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.no_photography, color: Colors.white, size: 48),
          const SizedBox(height: 12),
          Text(
            message ?? 'Camera error',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}