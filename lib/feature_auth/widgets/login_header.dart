import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A widget that displays the Moodle branding and site information.
///
/// This includes the official Moodle logo provided as an asset, the site
/// name, and the specific LMS URL with pixel-perfect spacing.
class LoginHeader extends StatelessWidget {
  /// Creates an instance of [LoginHeader].
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Moodle Logo with Graduation Cap and TM
          // Sized to 380 to match the large scale in the reference screenshot
          Image.asset(
            'assets/images/moodle_logo.png',
            width: 380,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.school,
              size: 80,
              color: AppTheme.moodleOrange,
            ),
          ),
          // Reduced gap for pixel-perfect ratio
          const SizedBox(height: 4),
          // Site display name - eLearning23
          const Text(
            AppStrings.labelSiteName,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppTheme.moodleDarkGrey,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 2),
          // Specific Moodle instance URL
          const Text(
            AppStrings.labelSiteUrl,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: AppTheme.moodleMediumGrey,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
