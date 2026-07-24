import 'package:flutter/material.dart';

class ReconnectQrButton extends StatelessWidget {
  const ReconnectQrButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFF9E9E9E), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.qr_code_scanner,
              size: 20,
              color: Color(0xFF212121),
            ),
            SizedBox(width: 8),
            Text(
              'Scan QR code',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121),
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}