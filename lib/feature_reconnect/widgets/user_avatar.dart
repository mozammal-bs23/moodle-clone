import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 78,
          height: 78,
          decoration: const BoxDecoration(
            color: Color(0xFFE8ECEF),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'SU',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF37474F),
              letterSpacing: 0,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Student User',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}