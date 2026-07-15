import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Screen displayed when an unhandled error occurs
class ErrorScreen extends StatelessWidget {
  /// Creates an error screen
  const ErrorScreen({
    required this.error,
    this.stackTrace,
    this.onRetry,
    super.key,
  });

  /// Error message
  final String error;

  /// Stack trace (optional)
  final String? stackTrace;

  /// Callback to retry
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    const redColor = Color(0xFFB71C1C);
    const bgColor = Color(0xFFFFEBEE);

    return Material(
      color: bgColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            const Icon(
              Icons.error_outline,
              size: 64,
              color: redColor,
            ),
            SizedBox(height: 24.h),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF7F0000),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'An unexpected error occurred. Our team has been notified.',
              style: TextStyle(
                fontSize: 14.sp,
                color: redColor,
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCDD2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Error Details:',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SelectableText(
                    error,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'monospace',
                    ),
                  ),
                  if (stackTrace != null) ...[
                    SizedBox(height: 16.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: redColor),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          'Stack Trace',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.w),
                            child: SelectableText(
                              stackTrace!,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: redColor,
                borderRadius: BorderRadius.circular(4.r),
                child: InkWell(
                  onTap: onRetry,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.refresh, color: Colors.white),
                        SizedBox(width: 8.w),
                        const Text(
                          'Try Again',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(4.r),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: redColor),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.home, color: redColor),
                          SizedBox(width: 8.w),
                          const Text(
                            'Go Home',
                            style: TextStyle(color: redColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
