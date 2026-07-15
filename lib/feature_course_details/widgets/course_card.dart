import 'package:flutter/material.dart';

import 'package:flutter_boilerplate/feature_course_details/widgets/course_progress.dart';
import 'package:flutter_boilerplate/feature_course_details/widgets/course_date.dart';
import 'package:flutter_boilerplate/feature_course_details/widgets/course_summary.dart';
import 'package:flutter_boilerplate/feature_course_details/widgets/teacher_tile.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * .68,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Celebrating Cultures',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffFCE5C7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Our Community',
                  style: TextStyle(color: Colors.brown),
                ),
              ),

              const SizedBox(height: 22),

              const CourseProgress(),

              const CourseDate(),

              const CourseSummary(),

              const TeacherTile(),
            ],
          ),
        ),
      ),
    );
  }
}
