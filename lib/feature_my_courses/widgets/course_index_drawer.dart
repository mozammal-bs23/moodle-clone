import 'package:flutter/material.dart';

import 'package:flutter_boilerplate_domain/flutter_boilerplate_domain.dart';

/// Modal bottom sheet that lists every section + module for the
/// current course. Tap any row to scroll the contents list to it and
/// close the sheet.
///
/// Matches the "Course index" reference in the real Moodle app:
///   * Title row: "Course index" on the left, close `×` on the right.
///   * "All sections" header row.
///   * Sections rendered as bold rows; the currently-active one is
///     highlighted with the warm peach background.
///   * Modules indented underneath each section.
class CourseIndexDrawer extends StatelessWidget {
  /// Creates a [CourseIndexDrawer].
  const CourseIndexDrawer({
    super.key,
    required this.sections,
    required this.onTapAnchor,
    this.activeSectionId,
  });

  /// Sections to render (in display order).
  final List<CourseSectionEntity> sections;

  /// Anchor id to scroll to when an item is tapped. The parent's
  /// `CourseContentsList` keeps a `Map<String, GlobalKey>` and exposes
  /// `scrollToAnchor(id)`. We forward the id here and let the parent
  /// do the actual scrolling.
  final ValueChanged<String> onTapAnchor;

  /// The id of the section the user is currently viewing (used to
  /// highlight the matching row). May be `null` if the page hasn't
  /// computed an active section yet.
  final int? activeSectionId;

  /// Convenience launcher — opens the sheet on the given [context].
  static Future<void> show(
    BuildContext context, {
    required List<CourseSectionEntity> sections,
    required ValueChanged<String> onTapAnchor,
    int? activeSectionId,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, controller) => CourseIndexDrawer(
            sections: sections,
            onTapAnchor: (id) {
              Navigator.of(sheetContext).pop();
              onTapAnchor(id);
            },
            activeSectionId: activeSectionId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final peachHighlight = const Color(0xFFF5E6DA);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle + title row.
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Course index',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Close',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        // "All sections" header.
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'All sections',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Divider(height: 1, color: theme.colorScheme.outlineVariant),
        Flexible(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              for (final s in sections)
                _SectionRow(
                  section: s,
                  isActive: s.id == activeSectionId,
                  highlight: peachHighlight,
                  onTapAnchor: onTapAnchor,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({
    required this.section,
    required this.isActive,
    required this.highlight,
    required this.onTapAnchor,
  });

  final CourseSectionEntity section;
  final bool isActive;
  final Color highlight;
  final ValueChanged<String> onTapAnchor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => onTapAnchor('section:${section.id}'),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
            color: isActive ? highlight : null,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    section.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        for (final m in section.modules)
          InkWell(
            onTap: () => onTapAnchor('module:${m.id}'),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36, 8, 20, 8),
              child: Text(
                m.name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
      ],
    );
  }
}