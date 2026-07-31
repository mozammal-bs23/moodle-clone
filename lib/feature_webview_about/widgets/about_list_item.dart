import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable list row used by the About page entries.
///
/// Renders a leading icon and a label. By default a chevron is shown
/// on the right (matching the App Settings page's chevron styling —
/// same icon, color, and size); callers may override the trailing
/// widget when needed.
class AboutListItem extends StatelessWidget {
  /// Creates an instance of [AboutListItem].
  const AboutListItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    super.key,
  });

  /// The icon shown at the start of the row.
  final IconData icon;

  /// The text label for the item.
  final String label;

  /// Optional widget shown at the end of the row. Defaults to a
  /// chevron pointing right when omitted.
  final Widget? trailing;

  /// Callback invoked when the row is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.md.h,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: AppSize.iconMd.r,
              color: AppTheme.moodleDarkGrey,
            ),
            SizedBox(width: AppSpacing.md.w),
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
            trailing ?? const _DefaultTrailingIcon(),
          ],
        ),
      ),
    );
  }
}

/// The default chevron used by [AboutListItem] when no trailing widget
/// is supplied by the caller.
///
/// Visually identical to the trailing chevron on the App Settings
/// page — same Material `Icons.chevron_right`, same colour, and same
/// `AppSize.iconMd` size.
class _DefaultTrailingIcon extends StatelessWidget {
  /// Creates an instance of [_DefaultTrailingIcon].
  const _DefaultTrailingIcon();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.chevron_right,
      color: AppTheme.moodleMediumGrey,
      size: AppSize.iconMd.r,
    );
  }
}
