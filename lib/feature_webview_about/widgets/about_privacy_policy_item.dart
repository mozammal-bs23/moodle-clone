import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The "Privacy policy" entry on the About page.
///
/// Trailing open-in-new icon indicates the link opens an external URL
/// (https://moodle.net/moodle-app-privacy/) in the device browser.
/// The actual URL launch will be wired later.
class AboutPrivacyPolicyItem extends StatelessWidget {
  /// Creates an instance of [AboutPrivacyPolicyItem].
  const AboutPrivacyPolicyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListItem(
      icon: Icons.privacy_tip,
      label: AboutConstants.labelPrivacyPolicy,
      trailing: Icon(
        Icons.open_in_new,
        color: AppTheme.moodleMediumGrey,
        size: AboutConstants.trailingIconSize.r,
      ),
      onTap: () {
        // TODO(Nadim): launch https://moodle.net/moodle-app-privacy/.
      },
    );
  }
}
