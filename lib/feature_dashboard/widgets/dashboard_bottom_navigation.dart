import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A bottom navigation bar widget for the dashboard.
class DashboardBottomNavigation extends StatelessWidget {
  /// Creates a [DashboardBottomNavigation].
  const DashboardBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper to ensure font/icon size is always > 0
    double safeSp(double size) => size.sp > 0 ? size.sp : size;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 1.h),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.black,
        unselectedItemColor: AppColors.grey700,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          _buildNavItem(Icons.speed, true, safeSp),
          _buildNavItem(Icons.school_outlined, false, safeSp),
          _buildNavItem(Icons.chat_bubble_outline, false, safeSp),
          _buildNavItem(Icons.notifications_none, false, safeSp),
          _buildNavItem(Icons.more_horiz, false, safeSp),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    bool isActive,
    double Function(double) safeSp,
  ) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3.h,
            width: 45.w,
            decoration: BoxDecoration(
              color: isActive ? AppColors.moodleOrange : Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(3.r),
                bottomRight: Radius.circular(3.r),
              ),
            ),
          ),
          SizedBox(height: AppSpacing.md.h),
          Icon(icon, size: safeSp(28)),
          SizedBox(height: AppSpacing.sm.h),
        ],
      ),
      label: '',
    );
  }
}
