import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Placeholder for the Calendar destination reached from the Dashboard
/// "Calendar" row and from the Site-home "Calendar" row.
///
/// The full Calendar (events, upcoming, settings, new-event flow) will
/// live on its own branch (`feature/calendar-modular`).
class CalendarPage extends StatelessWidget {
  /// Creates a [CalendarPage].
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    double safeSp(double size) => size.sp > 0 ? size.sp : size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Calendar',
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppFontSize.xxl.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.black),
            onPressed: () =>
                ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Calendar coming soon')),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.event_outlined,
                size: 80.w,
                color: AppColors.grey300,
              ),
              SizedBox(height: AppSpacing.md.h),
              Text(
                'No events yet',
                style: TextStyle(
                  fontSize: safeSp(AppFontSize.lg),
                  color: AppColors.grey600,
                ),
              ),
              SizedBox(height: AppSpacing.xs.h),
              Text(
                'Your calendar events will appear here. The full calendar '
                'feature ships in a future update.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: safeSp(AppFontSize.md),
                  color: AppColors.grey500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
