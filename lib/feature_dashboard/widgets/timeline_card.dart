import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card widget that displays a timeline of activities.
class TimelineCard extends StatelessWidget {
  /// Creates a [TimelineCard].
  const TimelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    double safeSp(double size) => size.sp > 0 ? size.sp : size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeline',
            style: TextStyle(
              fontSize: safeSp(18),
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.h),
          _buildSearchField(safeSp),
          SizedBox(height: 12.h),
          _buildFilterRow(safeSp),
          SizedBox(height: 40.h),
          _buildEmptyState(safeSp),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSearchField(double Function(double) safeSp) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: const Color(0xFFBDBDBD)),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: safeSp(14)),
              decoration: InputDecoration(
                hintText: 'Search by activity type or name',
                hintStyle: TextStyle(
                  color: const Color(0xFF757575),
                  fontSize: safeSp(14),
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Icon(Icons.search, color: const Color(0xFF757575), size: safeSp(22)),
          SizedBox(width: 8.w),
          Icon(
            Icons.backspace_outlined,
            color: const Color(0xFF757575),
            size: safeSp(18),
          ),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }

  Widget _buildFilterRow(double Function(double) safeSp) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: const Color(0xFFBDBDBD)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Next 30 days',
                style: TextStyle(color: Colors.black87, fontSize: safeSp(14)),
              ),
              Icon(Icons.arrow_drop_down, size: safeSp(20)),
            ],
          ),
        ),
        const Spacer(),
        Icon(Icons.swap_vert, color: Colors.black87, size: safeSp(24)),
      ],
    );
  }

  Widget _buildEmptyState(double Function(double) safeSp) {
    return Center(
      child: Column(
        children: [
          // Custom 4-block illustration to match Moodle UI exactly
          Container(
            width: 80.w,
            height: 90.h,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                4,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 20,
                        color: const Color(0xFFEEEEEE),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        height: 4,
                        width: 20,
                        color: const Color(0xFFEEEEEE),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No activities require action',
            style: TextStyle(
              color: const Color(0xFF424242),
              fontSize: safeSp(16),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
