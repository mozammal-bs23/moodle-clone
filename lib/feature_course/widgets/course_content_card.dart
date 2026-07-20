import 'package:flutter/material.dart';

/// A card that displays the welcome content in an expandable format.
class CourseContentCard extends StatelessWidget {
  /// Creates a [CourseContentCard].
  const CourseContentCard({
    required this.title,
    required this.description,
    required this.isExpanded,
    required this.onExpansionChanged,
    super.key,
  });

  /// The title of the content.
  final String title;
  /// The description of the content.
  final String description;
  /// Whether the card is currently expanded.
  final bool isExpanded;
  /// Callback when the expansion state changes.
  final ValueChanged<bool> onExpansionChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        onExpansionChanged: onExpansionChanged,
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              description,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
