import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Tappable "Lost password?" link rendered beneath the login button.
///
/// Lives in its own file so `LoginForm` stays focused on field layout
/// and the lost-password affordance can be iterated on independently
/// (e.g. later it needs to navigate to `/forgot-password`).
class LostPasswordLink extends StatelessWidget {
  /// Creates a [LostPasswordLink].
  const LostPasswordLink({super.key, this.onTap});

  /// Called when the user taps the link. Defaults to a no-op so the
  /// widget is trivially usable in previews and tests; the parent
  /// typically wires this to `context.go(AppRoutes.forgotPassword)`.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Text(
        AppStrings.labelLostPassword,
        style: TextStyle(
          color: AppTheme.moodleLinkGrey,
          decoration: TextDecoration.underline,
          decorationThickness: 1.2,
          fontSize: 14.5.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
