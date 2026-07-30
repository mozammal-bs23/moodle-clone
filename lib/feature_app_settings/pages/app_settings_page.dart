import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_app_settings/widgets/settings_about_item.dart';
import 'package:flutter_boilerplate/feature_app_settings/widgets/settings_general_item.dart';
import 'package:flutter_boilerplate/feature_app_settings/widgets/settings_space_usage_item.dart';
import 'package:flutter_boilerplate/feature_app_settings/widgets/settings_sync_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The App Settings page providing configuration options.
///
/// This screen allows users to manage general settings, space usage,
/// synchronisation preferences, and view information about the app.
class AppSettingsPage extends StatelessWidget {
  /// Creates an instance of [AppSettingsPage].
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: ListView(
        children: const [
          SettingsGeneralItem(),
          SettingsSpaceUsageItem(),
          SettingsSyncItem(),
          SettingsAboutItem(),
        ],
      ),
    );
  }

  /// Builds the AppBar for the App Settings page.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: AppTheme.moodleDarkGrey,
          size: AppSize.iconMd.r,
        ),
        onPressed: () => context.pop<void>(),
      ),
      title: Text(
        AppStrings.labelAppSettings,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
