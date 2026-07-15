import 'package:flutter/material.dart';

class CourseProgress extends StatelessWidget {
  const CourseProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const LinearProgressIndicator(
                  value: .27,
                  minHeight: 8,
                  color: Colors.orange,
                  backgroundColor: Color(0xffFBE5D6),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text('27%', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
