import 'package:flutter/material.dart';

class MoodleLogo extends StatelessWidget {
  const MoodleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        height: 80,
        child: Image.asset(
          'assets/images/moodle_logo.png',
          fit: BoxFit.contain,
          alignment: Alignment.center,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
