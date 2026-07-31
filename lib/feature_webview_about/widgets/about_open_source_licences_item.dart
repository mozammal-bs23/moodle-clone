import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_list_item.dart';

/// The "Open Source Licences" entry on the About page.
///
/// Tap-handler is a placeholder — wired to navigate to the Open
/// Source Licences sub-screen later.
class AboutOpenSourceLicencesItem extends StatelessWidget {
  /// Creates an instance of [AboutOpenSourceLicencesItem].
  const AboutOpenSourceLicencesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListItem(
      icon: Icons.copyright,
      label: AboutConstants.labelOpenSourceLicences,
      onTap: () {
        // TODO(Nadim): navigate to Open Source Licences sub-screen.
      },
    );
  }
}
