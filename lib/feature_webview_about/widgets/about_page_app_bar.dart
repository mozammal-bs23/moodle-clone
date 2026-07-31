import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_webview_about/about_constants.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Builds the AppBar for the About page.
///
/// Features a back button and a bold "About" title aligned to the left
/// of the bar — matching the reference screenshot exactly.
PreferredSizeWidget buildAboutPageAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AboutConstants.pageBackground,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: AppTheme.moodleDarkGrey,
        size: AppSize.iconMd.r,
      ),
      onPressed: () => Navigator.of(context).pop<void>(),
    ),
    title: Text(
      AppStrings.labelAbout,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: AppSize.fontLg.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
