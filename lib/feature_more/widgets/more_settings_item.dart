import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_more/widgets/more_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A specialized menu item for the App Settings feature.
class MoreSettingsItem extends StatelessWidget {
  /// Creates an instance of [MoreSettingsItem].
  const MoreSettingsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreListItem(
      icon: Icons.miscellaneous_services,
      label: AppStrings.labelAppSettings,
      onTap: () {
        // Will navigate to detailed App Strings/Settings later
      },
    );
  }
}
