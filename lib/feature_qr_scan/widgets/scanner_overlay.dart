import 'package:flutter/material.dart';

/// A full-screen overlay that dims the camera viewfinder and cuts out a
/// transparent square in the middle for the user to align the QR code
/// inside.
///
/// The overlay is built with a [CustomPainter] so the cutout is a true
/// hole (not a half-transparent grey box) — that matches the look of the
/// reference screenshots.
class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key, this.cutoutSize = 260});

  /// Side length of the square cutout, in logical pixels.
  final double cutoutSize;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _OverlayPainter(cutoutSize: cutoutSize),
      ),
    );
  }
}

class _OverlayPainter extends CustomPainter {
  _OverlayPainter({required this.cutoutSize});

  final double cutoutSize;

  @override
  void paint(Canvas canvas, Size size) {
    final overlay = Paint()..color = const Color(0xCC000000);

    final cx = size.width / 2;
    final cy = size.height / 2;
    final rect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: cutoutSize,
      height: cutoutSize,
    );

    // Build an "outer minus inner" path so we get a real transparent hole.
    final outer = Path()..addRect(Offset.zero & size);
    final inner = Path()
      ..addRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(16)),
      );
    final hollow = Path.combine(PathOperation.difference, outer, inner);
    canvas.drawPath(hollow, overlay);

    // White border around the cutout to make it easy to see.
    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(16)),
      border,
    );
  }

  @override
  bool shouldRepaint(covariant _OverlayPainter old) =>
      old.cutoutSize != cutoutSize;
}