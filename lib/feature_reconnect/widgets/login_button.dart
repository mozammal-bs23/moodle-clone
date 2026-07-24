import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.isEnabled,
  });

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: isEnabled ? () {} : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? const Color(0xFFF9A865) // Dark orange
              : const Color(0xFFFCD5B5), // Light orange
          disabledBackgroundColor: const Color(0xFFFCD5B5),
          disabledForegroundColor: const Color(0xFF212121),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: const Text(
          'Log in',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}