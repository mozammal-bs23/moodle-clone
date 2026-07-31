import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_more/widgets/more_list_item.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A specialized menu item for the Calendar feature.
class MoreCalendarItem extends StatelessWidget {
  /// Creates an instance of [MoreCalendarItem].
  const MoreCalendarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreListItem(
      icon: Icons.calendar_today,
      label: AppStrings.labelCalendar,
      onTap: () {
        // Will navigate to detailed Calendar page later
      },
    );
  }
}
