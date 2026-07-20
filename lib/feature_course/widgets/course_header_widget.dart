import 'package:flutter/material.dart';

/// A widget that displays the course header with a styled progress bar.
class CourseHeaderWidget extends StatelessWidget {
  /// Creates a [CourseHeaderWidget].
  const CourseHeaderWidget({
    required this.progress,
    super.key,
  });

  /// The progress value between 0.0 and 1.0.
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Container(width: 50, height: 50, color: Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Celebrating Cultures',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    // Slightly thicker height
                    minHeight: 10,
                    // Uses app theme colors instead of hardcoded values
                    backgroundColor: theme.colorScheme.outlineVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('${(progress * 100).toInt()}%'),
            ],
          ),
        ],
      ),
    );
  }
}
