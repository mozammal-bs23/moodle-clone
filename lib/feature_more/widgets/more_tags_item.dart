import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_more/widgets/more_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A specialized menu item for the Tags feature.
class MoreTagsItem extends StatelessWidget {
  /// Creates an instance of [MoreTagsItem].
  const MoreTagsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreListItem(
      icon: Icons.local_offer,
      label: AppStrings.labelTags,
      onTap: () {
        // Will navigate to detailed Tags page later
      },
    );
  }
}
