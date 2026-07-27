import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable list item for the "More" screen menu.
///
/// Features a leading icon, a label, and a trailing chevron.
class MoreListItem extends StatelessWidget {
  /// Creates an instance of [MoreListItem].
  const MoreListItem({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  /// The icon to display at the start of the row.
  final IconData icon;

  /// The text label for the item.
  final String label;

  /// Callback when the item is tapped.
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.moodleDarkGrey,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppTheme.moodleMediumGrey,
              size: AppSize.iconMd.r,
            ),
          ],
        ),
      ),
    );
  }
}
