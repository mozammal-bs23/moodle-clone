import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_more/widgets/more_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A specialized menu item for the Site Blog feature.
class MoreBlogItem extends StatelessWidget {
  /// Creates an instance of [MoreBlogItem].
  const MoreBlogItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreListItem(
      icon: Icons.newspaper,
      label: AppStrings.labelSiteBlog,
      onTap: () {
        // Will navigate to detailed Site Blog page later
      },
    );
  }
}
