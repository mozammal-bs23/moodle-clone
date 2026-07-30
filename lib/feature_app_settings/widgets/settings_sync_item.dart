import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_more/widgets/more_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A specialized menu item for the Synchronisation feature.
class SettingsSyncItem extends StatelessWidget {
  /// Creates an instance of [SettingsSyncItem].
  const SettingsSyncItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreListItem(
      icon: Icons.sync,
      label: AppStrings.labelSynchronisation,
      onTap: () {},
    );
  }
}
