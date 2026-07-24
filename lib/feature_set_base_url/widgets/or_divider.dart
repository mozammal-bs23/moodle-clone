import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Or',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF212121),
          letterSpacing: 0,
          height: 1,
        ),
      ),
    );
  }
}
