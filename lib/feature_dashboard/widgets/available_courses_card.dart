import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:flutter_boilerplate_core/utils/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// A card widget that displays the "Available courses" section in Site Home.
class AvailableCoursesCard extends StatelessWidget {
  /// Creates an [AvailableCoursesCard].
  const AvailableCoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(AppRoutes.availableCourses),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSpacing.std.w,
          vertical: AppSpacing.md.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.std.w,
          vertical: 20.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSize.radiusLg.r),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Icon(
              Icons.school,
              size: AppSize.iconMd.w,
              color: AppColors.grey800,
            ),
            SizedBox(width: AppSpacing.md.w),
            Text(
              'Available courses',
              style: TextStyle(
                fontSize: AppFontSize.lg.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
