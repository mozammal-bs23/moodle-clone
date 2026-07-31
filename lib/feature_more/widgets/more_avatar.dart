import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A widget that displays a circular avatar with the user's initials.
///
/// Tapping on this avatar will later navigate to the User Profile page.
class MoreAvatar extends StatelessWidget {
  /// Creates an instance of [MoreAvatar].
  const MoreAvatar({
    required this.name,
    this.onTap,
    super.key,
  });

  /// The full name used to generate initials.
  final String name;

  /// Callback when the avatar is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(4.r), // Adds hit area
          child: CircleAvatar(
            radius: 18.r,
            backgroundColor: AppTheme.moodleBorderGrey,
            child: Text(
              _getInitials(name),
              style: TextStyle(
                color: AppTheme.moodleDarkGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Extracts the first letter of the first and last name.
  String _getInitials(String name) {
    if (name.isEmpty) return '??';
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts.last[0]).toUpperCase();
  }
}
