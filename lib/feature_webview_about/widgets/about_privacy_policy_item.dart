import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_list_item.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

/// The "Privacy policy" entry on the About page.
///
/// Tapping the row opens the privacy policy URL inside an in-app
/// WebView via [AppRoutes.webview].
class AboutPrivacyPolicyItem extends StatelessWidget {
  /// Creates an instance of [AboutPrivacyPolicyItem].
  const AboutPrivacyPolicyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListItem(
      icon: Icons.privacy_tip,
      label: AboutConstants.labelPrivacyPolicy,
      onTap: () => context.pushNamed(
        AppRoutes.webview,
        extra: AboutConstants.privacyPolicyUrl,
      ),
    );
  }
}
