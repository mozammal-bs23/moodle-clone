import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AppBar for [LoginPageScaffold] matching the reference screenshot.
///
/// Pulled out of `login_page_scaffold.dart` so the scaffold file stays
/// focused on its BlocListener and body layout.
PreferredSizeWidget buildLoginPageAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleSpacing: 0,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).colorScheme.onSurface,
        size: AppSize.iconMd.r,
      ),
      onPressed: () {},
    ),
    title: Text(
      AppStrings.labelLogin,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: 19.sp,
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Theme.of(context).colorScheme.onSurface,
          size: AppSize.iconMd.r,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.help_outline,
          color: Theme.of(context).colorScheme.onSurface,
          size: AppSize.iconMd.r,
        ),
        onPressed: () {},
      ),
    ],
  );
}
