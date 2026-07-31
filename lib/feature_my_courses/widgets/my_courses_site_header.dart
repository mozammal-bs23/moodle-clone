import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/feature_my_courses/utils/my_courses_strings.dart';

/// Top-of-page site header shown on every post-login screen.
///
/// Layout (matches `Screenshot_20260723-162233.jpg`):
///   • Bold site name on the left.
///   • Circular avatar with user initials on the right, tinted with the
///     theme's surface-container-highest so it reads as a flat disk.
///
/// Site name and initials are hard-coded for now and will be replaced
/// with values from the user's profile once the API is available.
class MyCoursesSiteHeader extends StatelessWidget {
  const MyCoursesSiteHeader({
    super.key,
    this.siteName = MyCoursesStrings.siteName,
    this.userInitials = MyCoursesStrings.userInitials,
    this.onAvatarTap,
  });

  final String siteName;
  final String userInitials;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Neutral grey disk in light mode to match the design; use the
    // theme's surfaceContainerHighest in dark mode for proper contrast.
    final avatarBg = isDark
        ? theme.colorScheme.surfaceContainerHighest
        : const Color(0xFFEDEFF1);
    final avatarFg = isDark
        ? theme.colorScheme.onSurfaceVariant
        : const Color(0xFF1F2937);

    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              siteName,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          Material(
            color: avatarBg,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onAvatarTap,
              child: SizedBox(
                width: 40.w,
                height: 40.w,
                child: Center(
                  child: Text(
                    userInitials,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: avatarFg,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
