import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_list_item.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

/// The "Accessibility statement" entry on the About page.
///
/// Tapping the row opens the accessibility statement URL inside an
/// in-app WebView via [AppRoutes.webview].
class AboutAccessibilityStatementItem extends StatelessWidget {
  /// Creates an instance of [AboutAccessibilityStatementItem].
  const AboutAccessibilityStatementItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListItem(
      icon: Icons.accessibility_new,
      label: AboutConstants.labelAccessibilityStatement,
      onTap: () => context.pushNamed(
        AppRoutes.webview,
        extra: AboutConstants.accessibilityStatementUrl,
      ),
    );
  }
}
