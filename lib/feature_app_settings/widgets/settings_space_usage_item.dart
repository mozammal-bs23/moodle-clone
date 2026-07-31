import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_more/widgets/more_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A specialized menu item for the Space Usage feature.
class SettingsSpaceUsageItem extends StatelessWidget {
  /// Creates an instance of [SettingsSpaceUsageItem].
  const SettingsSpaceUsageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreListItem(
      icon: Icons.format_list_bulleted,
      label: AppStrings.labelSpaceUsage,
      onTap: () {},
    );
  }
}
