import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_more/widgets/more_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A specialized menu item for the General Settings feature.
class SettingsGeneralItem extends StatelessWidget {
  /// Creates an instance of [SettingsGeneralItem].
  const SettingsGeneralItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreListItem(
      icon: Icons.build,
      label: AppStrings.labelGeneral,
      onTap: () {},
    );
  }
}
