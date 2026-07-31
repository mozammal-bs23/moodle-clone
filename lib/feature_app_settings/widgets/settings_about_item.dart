import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_more/widgets/more_list_item.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:go_router/go_router.dart';

/// A specialized menu item for the About feature.
class SettingsAboutItem extends StatelessWidget {
  /// Creates an instance of [SettingsAboutItem].
  const SettingsAboutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreListItem(
      icon: Icons.badge,
      label: AppStrings.labelAbout,
      onTap: () => context.pushNamed(AppRoutes.about),
    );
  }
}
