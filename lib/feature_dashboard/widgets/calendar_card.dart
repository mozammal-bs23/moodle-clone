import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card widget that displays a "Calendar" label with a chevron icon.
class CalendarCard extends StatelessWidget {
  /// Creates a [CalendarCard].
  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSpacing.std.w),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.std.w,
        vertical: 18.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.radiusMd.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Text(
            'Calendar',
            style: TextStyle(
              fontSize: AppFontSize.xl.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black87,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right,
            color: AppColors.grey600,
            size: AppSize.iconMd.sp,
          ),
        ],
      ),
    );
  }
}
