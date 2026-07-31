import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/feature_my_courses/utils/my_courses_strings.dart';

/// Tabs in the bottom navigation bar.
enum MyCoursesNavTab {
  dashboard(
    label: MyCoursesStrings.navDashboard,
    icon: Icons.speed_outlined,
    activeIcon: Icons.speed,
  ),
  courses(
    label: MyCoursesStrings.navCourses,
    icon: Icons.school_outlined,
    activeIcon: Icons.school,
  ),
  messages(
    label: MyCoursesStrings.navMessages,
    icon: Icons.chat_bubble_outline,
    activeIcon: Icons.chat_bubble,
  ),
  notifications(
    label: MyCoursesStrings.navNotifications,
    icon: Icons.notifications_none,
    activeIcon: Icons.notifications,
  ),
  more(
    label: MyCoursesStrings.navMore,
    icon: Icons.more_horiz,
    activeIcon: Icons.more_horiz,
  );

  const MyCoursesNavTab({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

/// Five-tab bottom navigation matching the target design:
///   • Each tab: icon above, label below.
///   • Active tab gets an orange indicator (3 px) above the icon and the
///     filled variant of the icon (matches the orange bar over the
///     graduation cap in the screenshot).
class MyCoursesBottomNav extends StatelessWidget {
  const MyCoursesBottomNav({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  final MyCoursesNavTab currentTab;
  final ValueChanged<MyCoursesNavTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72.h,
          child: Row(
            children: MyCoursesNavTab.values
                .map(
                  (tab) => Expanded(
                    child: _NavBarItem(
                      tab: tab,
                      isActive: tab == currentTab,
                      onTap: () => onTabSelected(tab),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
  });

  final MyCoursesNavTab tab;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const activeAccent = Color(0xFFFF6F1A); // Orange indicator.
    final inactiveColor = theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Orange indicator bar (3 px) — present when active, transparent
          // when inactive so layout doesn't shift between tabs.
          Container(
            width: 40.w,
            height: 3,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: isActive ? activeAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Spacer(),
          Icon(
            isActive ? tab.activeIcon : tab.icon,
            size: 24.sp,
            color: isActive ? theme.colorScheme.onSurface : inactiveColor,
          ),
          SizedBox(height: 4.h),
          Text(
            tab.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isActive ? theme.colorScheme.onSurface : inactiveColor,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}