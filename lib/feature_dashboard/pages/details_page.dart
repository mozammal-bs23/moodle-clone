import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/utils/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Page displaying detailed information about a user.
class DetailsPage extends StatelessWidget {
  /// Creates a [DetailsPage].
  const DetailsPage({super.key});

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
          'Details',
          style: TextStyle(
            color: AppColors.black,
            fontSize: safeSp(AppFontSize.xxl),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('User details', safeSp),
            _buildDetailItem('Email address', 'admin@example.com', safeSp),
            const Divider(),
            _buildDetailItem('City/town', 'Dhaka', safeSp),
            const Divider(),
            _buildDetailItem('Country', 'Bangladesh', safeSp),
            SizedBox(height: AppSpacing.lg.h),
            _buildSectionHeader('Privacy and policies', safeSp),
            _buildDetailItem('Data retention summary', '', safeSp, isLink: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, double Function(double) safeSp) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: safeSp(AppFontSize.xl),
          fontWeight: FontWeight.bold,
          color: AppColors.moodleOrange,
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    String label,
    String value,
    double Function(double) safeSp, {
    bool isLink = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: safeSp(AppFontSize.md),
              color: AppColors.grey600,
            ),
          ),
          if (value.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: safeSp(AppFontSize.lg),
                color: isLink ? AppColors.blue : AppColors.black87,
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
