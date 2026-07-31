import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Splash Screen for the Moodle Clone application.
///
/// This screen displays the official Moodle logo centered on a white
/// background and navigates to the login screen after a short delay.
class SplashPage extends StatefulWidget {
  /// Creates an instance of [SplashPage].
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  /// Navigates to the login screen after a short delay.
  Future<void> _navigateToNext() async {
    // Standard splash delay (3 seconds)
    await Future<void>.delayed(const Duration(seconds: 3));
    if (mounted) {
      // Navigates to login page using GoRouter
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          AppAssets.moodleSplashLogo,
          width: AppSize.splashLogoWidth.w,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.school,
            size: AppSize.splashLogoErrorSize.r,
            color: AppBrandColors.moodleOrange,
          ),
        ),
      ),
    );
  }
}
