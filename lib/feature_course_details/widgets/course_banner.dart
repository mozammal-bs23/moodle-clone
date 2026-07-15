import 'package:flutter/material.dart';

class CourseBanner extends StatelessWidget {
  const CourseBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 270,
      child: Image.asset('assets/images/course_banner.png', fit: BoxFit.cover),
    );
  }
}
