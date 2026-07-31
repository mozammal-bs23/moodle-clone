import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// The bottom footer of the About page.
///
/// Displays the running app version, e.g. "Moodle Mobile 5.2.1".
/// Matches the small caption that sits just above the bottom system
/// navigation bar in the reference screenshot. Tapping the caption
/// is wired to a placeholder handler — to be replaced with navigation
/// to the version-details page when that feature is implemented.
class AboutFooter extends StatelessWidget {
  /// Creates an instance of [AboutFooter].
  const AboutFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Center(
          child: InkWell(
            onTap: () {
              // TODO(Nadim): navigate to the version-details page.
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
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
        ),
      ),
    );
  }
}
