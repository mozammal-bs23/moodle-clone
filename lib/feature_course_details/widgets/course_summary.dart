import 'package:flutter/material.dart';

class CourseSummary extends StatelessWidget {
  const CourseSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),

        Text(
          'Course summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),

        SizedBox(height: 10),

        Text(
          'An informal, optional module for Mount Orange students, staff and auxiliaries to celebrate and showcase the diversity of our traditions, languages and landscapes.',
          style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
        ),
      ],
    );
  }
}
