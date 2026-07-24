import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A custom header widget for the dashboard, implementing [PreferredSizeWidget].
class DashboardHeader extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [DashboardHeader].
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper to ensure font size is always > 0 to prevent assertion errors
    double safeSp(double size) => size.sp > 0 ? size.sp : size;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Text(
        'eLearning23',
        style: TextStyle(
          color: Colors.black,
          fontSize: safeSp(22),
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.black87, size: 26.w),
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.w, left: 4.w),
          child: CircleAvatar(
            radius: 16.r,
            backgroundColor: const Color(0xFFE0E0E0),
            child: Text(
              'SU',
              style: TextStyle(
                color: const Color(0xFF616161),
                fontWeight: FontWeight.w500,
                fontSize: safeSp(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
