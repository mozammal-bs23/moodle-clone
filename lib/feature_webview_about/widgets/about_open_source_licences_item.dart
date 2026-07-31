import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate/feature_webview_about/widgets/about_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// The "Open Source Licences" entry on the About page.
///
/// Trailing chevron indicates that tapping the row opens an in-app
/// sub-screen. The actual navigation target will be wired later.
class AboutOpenSourceLicencesItem extends StatelessWidget {
  /// Creates an instance of [AboutOpenSourceLicencesItem].
  const AboutOpenSourceLicencesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutListItem(
      icon: LucideIcons.copyright,
      label: AboutConstants.labelOpenSourceLicences,
      trailing: Icon(
        LucideIcons.chevronRight,
        color: AppTheme.moodleMediumGrey,
        size: AppSize.iconMd.r,
      ),
      onTap: () {
        // TODO(Nadim): navigate to Open Source Licences sub-screen.
      },
    );
  }
}
