import 'package:flutter/material.dart';

class ReconnectLogo extends StatelessWidget {
  const ReconnectLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'eLearning23',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: Color(0xFF212121),
            letterSpacing: -0.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'https://lmsmobile.ahnafmuttaki.com',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xFF616161),
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}