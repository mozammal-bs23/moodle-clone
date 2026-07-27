import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AvailableCoursesPage extends StatelessWidget {
  const AvailableCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    double safeSp(double size) => size.sp > 0 ? size.sp : size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Available courses',
          style: TextStyle(
            color: AppColors.black,
            fontSize: safeSp(AppFontSize.xxl),
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.std.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(safeSp),
            SizedBox(height: AppSpacing.md.h),
            _buildShowOnlyMyCoursesRow(safeSp),
            SizedBox(height: AppSpacing.lg.h),
            _buildCourseCard(safeSp),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(double Function(double) safeSp) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.radiusSm.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: safeSp(AppFontSize.md)),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: AppColors.grey600,
                  fontSize: safeSp(AppFontSize.md),
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: AppColors.grey600,
            size: safeSp(AppSize.iconMdLg),
          ),
          SizedBox(width: AppSpacing.sm.w),
          Icon(
            Icons.backspace_outlined,
            color: AppColors.grey600,
            size: safeSp(AppSize.iconSmMd),
          ),
          SizedBox(width: AppSpacing.md.w),
        ],
      ),
    );
  }

  Widget _buildShowOnlyMyCoursesRow(double Function(double) safeSp) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Show only my courses',
          style: TextStyle(
            fontSize: safeSp(AppFontSize.lg),
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        Switch(
          value: false,
          onChanged: (value) {},
          activeColor: AppColors.moodleOrange,
        ),
      ],
    );
  }

  Widget _buildCourseCard(double Function(double) safeSp) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.radiusLg.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: const Color(0xFFB3B1FF),
              borderRadius: BorderRadius.circular(AppSize.radiusMd.r),
            ),
            child: Icon(
              Icons.school,
              color: AppColors.white,
              size: safeSp(AppSize.iconLg),
            ),
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'AIDLC - New way of implementation',
                        style: TextStyle(
                          fontSize: safeSp(AppFontSize.lg),
                          fontWeight: FontWeight.w500,
                          color: AppColors.black87,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.lock,
                      size: safeSp(AppSize.iconSmMd),
                      color: AppColors.grey700,
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm.w,
                    vertical: AppSpacing.xs.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.moodleLightOrange,
                    borderRadius: BorderRadius.circular(AppSize.radiusFull.r),
                  ),
                  child: Text(
                    'Category 1',
                    style: TextStyle(
                      fontSize: safeSp(AppFontSize.sm),
                      color: AppColors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
