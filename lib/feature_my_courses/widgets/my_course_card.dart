import 'package:flutter/material.dart';

import 'package:flutter_boilerplate/feature_my_courses/cubit/my_courses_state.dart';
import 'package:flutter_boilerplate/feature_my_courses/utils/my_courses_strings.dart';

/// Actions exposed by the card's overflow menu.
enum MyCourseCardMenuAction { download, remove, favourite }

/// Card representing a single enrolled course.
///
/// Layout (matches the target design):
///   ┌──────────────────────────────────────────────┐
///   │ ▢  Course title           ⋮                  │
///   │    [Category chip]                           │
///   └──────────────────────────────────────────────┘
///
/// Implementation notes:
///   • No `Material`/`InkWell` wrappers — they conflict with `GridView`
///     cells by inserting their own `RenderCustomClip` between the
///     cell and the card content. The `Container` below provides the
///     same visual + a tap surface via `InkWell` inside `Stack` is not
///     needed; we use a plain `GestureDetector` for tap + a small
///     `Material` *only* under the popup anchor.
///   • All fixed widths use unconstrained logical pixels (no `.w`) so
///     they shrink gracefully in narrow grid cells.
class MyCourseCard extends StatelessWidget {
  const MyCourseCard({
    super.key,
    required this.course,
    this.onTap,
    this.onMenuAction,
  });

  final MyCourseItem course;
  final VoidCallback? onTap;

  /// Called when the user picks one of the ⋮ overflow menu items.
  final ValueChanged<MyCourseCardMenuAction>? onMenuAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Soft neutral border; outlineVariant is too purple-tinted in light
    // mode and too low-contrast in dark mode.
    final borderColor = isDark
        ? const Color(0xFF2A2A2E)
        : const Color(0xFFE5E7EB);

    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AvatarTile(tint: Color(course.colorSeed)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          course.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (course.isLocked) ...[
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Icon(
                            Icons.lock,
                            size: 16,
                            color: theme.colorScheme.onSurfaceVariant,
                            semanticLabel: MyCoursesStrings.lockedBadge,
                          ),
                        ),
                      ],
                      const SizedBox(width: 2),
                      _CardMenuButton(
                        onSelected: (action) => onMenuAction?.call(action),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _CategoryPill(label: course.category),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // Plain GestureDetector so the tap surface follows the card
    // shape without adding a Material/InkWell in front of the
    // GridView cell (which causes RenderCustomClip overflow in
    // tight cells).
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: course.isLocked ? null : onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: card,
      ),
    );
  }
}

/// Square avatar tile — purple/lavender background with a graduation cap.
/// Uses fixed logical pixels (no `.w`) so it stays a sensible size in
/// both list and grid contexts.
class _AvatarTile extends StatelessWidget {
  const _AvatarTile({required this.tint});

  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: tint,
      ),
      child: const Center(
        child: Icon(
          Icons.school_outlined,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

/// Pill-shaped category chip with warm peach background and brown text.
/// Matches the design asset exactly.
class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF5E6DA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF8B5A3C),
        ),
      ),
    );
  }
}

/// Vertical overflow menu (⋮) on the right side of each card.
/// Compact `IconButton`-driven `PopupMenuButton` so it doesn't push the
/// card row over its available height. The `PopupMenuButton` brings its
/// own `Material` so no wrapper is needed here.
class _CardMenuButton extends StatelessWidget {
  const _CardMenuButton({required this.onSelected});

  final ValueChanged<MyCourseCardMenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: PopupMenuButton<MyCourseCardMenuAction>(
        tooltip: MyCoursesStrings.cardMenuTooltip,
        icon: const Icon(Icons.more_vert, size: 18),
        padding: EdgeInsets.zero,
        splashRadius: 14,
        onSelected: onSelected,
        itemBuilder: (_) => const [
          PopupMenuItem(
            value: MyCourseCardMenuAction.download,
            child: Row(
              children: [
                Icon(Icons.cloud_download_outlined),
                SizedBox(width: 12),
                Text(MyCoursesStrings.cardMenuDownload),
              ],
            ),
          ),
          PopupMenuItem(
            value: MyCourseCardMenuAction.remove,
            child: Row(
              children: [
                Icon(Icons.remove_red_eye_outlined),
                SizedBox(width: 12),
                Text(MyCoursesStrings.cardMenuRemove),
              ],
            ),
          ),
          PopupMenuItem(
            value: MyCourseCardMenuAction.favourite,
            child: Row(
              children: [
                Icon(Icons.star_rounded),
                SizedBox(width: 12),
                Text(MyCoursesStrings.cardMenuFavourite),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
