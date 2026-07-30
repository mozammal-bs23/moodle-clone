import 'package:flutter/material.dart';

import 'package:flutter_boilerplate/feature_qr_scan/utils/qr_strings.dart';

/// The white app bar at the top of the scanner: a "Scan QR code" title and
/// a close (X) button. Matches the Moodle mobile design screenshots.
class ScannerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ScannerAppBar({super.key, required this.onClose});

  /// Called when the user taps the close (X) button.
  final VoidCallback onClose;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.white,
      titleSpacing: 20,
      title: const Text(
        QrStrings.title,
        style: TextStyle(
          color: Color(0xFF111111),
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.2,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onClose,
          tooltip: QrStrings.closeTooltip,
          icon: const Icon(Icons.close, size: 28, color: Color(0xFF111111)),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}