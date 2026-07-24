import 'package:flutter/material.dart';

class QrScanButton extends StatelessWidget {
  const QrScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.qr_code_2, size: 22, color: Color(0xFF212121)),
        label: const Text(
          'Scan QR code',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
            letterSpacing: 1,
          ),
        ),
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFF1E1E1E), width: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
