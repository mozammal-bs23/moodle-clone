import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable list row used by the About page entries.
///
/// Renders a leading icon, a label, and an optional trailing widget
/// (e.g. chevron for in-app navigation or open-in-new icon for
/// external links). Mirrors the visual style of the More page list
/// items but accepts an arbitrary trailing widget.
class AboutListItem extends StatelessWidget {
  /// Creates an instance of [AboutListItem].
  const AboutListItem({
    required this.icon,
    required this.label,
    required this.trailing,
    required this.onTap,
    super.key,
  });

  /// The icon shown at the start of the row.
  final IconData icon;

  /// The text label for the item.
  final String label;

  /// The widget shown at the end of the row (chevron / open icon).
  final Widget trailing;

  /// Callback invoked when the row is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.sm.h,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppSize.iconMd.r,
              color: AppTheme.moodleDarkGrey,
            ),
            SizedBox(width: AppSpacing.lg.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: AppSize.fontMd.sp,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.moodleDarkGrey,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
