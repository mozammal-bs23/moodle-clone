import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_accessibility_statement_item.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_footer.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_open_source_licences_item.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_page_app_bar.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_privacy_policy_item.dart';

/// The About page.
///
/// Lists the Open Source Licences entry, the Privacy policy link, and
/// the Accessibility statement link, with the app version caption
/// pinned to the bottom — pixel-perfect to the reference screenshot.
class AboutPage extends StatelessWidget {
  /// Creates an instance of [AboutPage].
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AboutConstants.pageBackground,
      appBar: buildAboutPageAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                AboutOpenSourceLicencesItem(),
                AboutPrivacyPolicyItem(),
                AboutAccessibilityStatementItem(),
              ],
            ),
          ),
          const AboutFooter(),
        ],
      ),
    );
  }
}
