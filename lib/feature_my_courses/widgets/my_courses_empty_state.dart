// Empty-state widgets for the My Courses page.
//
// Per the target design (image #1 / `assets/design/screens/...`), the
// My Courses screen does NOT show a "not enrolled" illustration when
// the list is empty — the filter row alone is the empty state. This
// file is kept as a placeholder so future flows (e.g. "no search
// results") can drop widgets here without re-creating the file.
import 'package:flutter/material.dart';

class MyCoursesNoSearchResults extends StatelessWidget {
  const MyCoursesNoSearchResults({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          query.isEmpty ? 'No courses' : 'No courses match "$query"',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}