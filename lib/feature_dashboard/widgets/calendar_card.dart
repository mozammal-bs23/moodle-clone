import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card widget that displays a "Calendar" label with a chevron icon.
class CalendarCard extends StatelessWidget {
  /// Creates a [CalendarCard].
  const CalendarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Text(
            'Calendar',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right,
            color: const Color(0xFF757575),
            size: 24.sp,
          ),
        ],
      ),
    );
  }
}
