import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// The bottom footer of the About page.
///
/// Displays the running app version, e.g. "Moodle Mobile 5.2.1".
/// Matches the small caption that sits just above the bottom system
/// navigation bar in the reference screenshot.
class AboutFooter extends StatelessWidget {
  /// Creates an instance of [AboutFooter].
  const AboutFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Center(
          child: Text(
            AboutConstants.labelAboutFooter,
            style: TextStyle(
              fontSize: AppSize.fontSm,
              fontWeight: FontWeight.w400,
              color: AppTheme.moodleDarkGrey,
            ),
          ),
        ),
      ),
    );
  }
}
