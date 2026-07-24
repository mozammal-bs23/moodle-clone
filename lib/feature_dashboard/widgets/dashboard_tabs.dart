import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A widget that displays tabs for the dashboard (e.g., Dashboard, Site home).
class DashboardTabs extends StatelessWidget {
  /// Creates a [DashboardTabs].
  const DashboardTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          _TabItem(
            title: 'Dashboard',
            isActive: true,
            onTap: () {},
          ),
          _TabItem(
            title: 'Site home',
            isActive: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Helper to ensure font size is always > 0 to prevent assertion errors
    double safeSp(double size) => size.sp > 0 ? size.sp : size;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: safeSp(15),
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? Colors.black87 : const Color(0xFF616161),
                ),
              ),
            ),
            Container(
              height: 3.h,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFD47A3A) : Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.r),
                  topRight: Radius.circular(3.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
