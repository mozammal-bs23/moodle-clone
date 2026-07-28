import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable section row used by Site Home and the More menu.
///
/// Renders a leading icon, a primary label and a trailing chevron. Tap is
/// delegated to [onTap] when provided.
class SectionMenuRow extends StatelessWidget {
  /// Creates a [SectionMenuRow].
  const SectionMenuRow({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    super.key,
  });

  /// Leading icon shown on the left side of the row.
  final IconData icon;

  /// Primary label of the row.
  final String title;

  /// Optional smaller subtitle shown under the [title].
  final String? subtitle;

  /// Tap callback invoked when the row is pressed.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double safeSp(double size) => size.sp > 0 ? size.sp : size;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSpacing.std.w,
          vertical: AppSpacing.md.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.std.w,
          vertical: 18.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.radiusLg.r),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Icon(icon, size: AppSize.iconMd.w, color: AppColors.grey800),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppFontSize.lg.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: AppSpacing.xs.h),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: safeSp(AppFontSize.md),
                        color: AppColors.grey600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.grey600,
              size: AppSize.iconMd.sp,
            ),
          ],
        ),
      ),
    );
  }
}
