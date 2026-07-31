import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The "Accessibility statement" entry on the About page.
///
/// Trailing open-in-new icon indicates the link opens an external URL
/// in the device browser. The actual URL launch will be wired later.
class AboutAccessibilityStatementItem extends StatelessWidget {
  /// Creates an instance of [AboutAccessibilityStatementItem].
  const AboutAccessibilityStatementItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListItem(
      icon: Icons.accessibility_new,
      label: AboutConstants.labelAccessibilityStatement,
      trailing: Icon(
        Icons.open_in_new,
        color: AppTheme.moodleMediumGrey,
        size: AboutConstants.trailingIconSize.r,
      ),
      onTap: () {
        // TODO(Nadim): launch accessibility statement URL.
      },
    );
  }
}
