import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature_dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter_boilerplate/feature_dashboard/utils/app_colors.dart';
import 'package:flutter_boilerplate/feature_dashboard/utils/app_constants.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/timeline_activity_grid_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A card widget that displays a timeline of activities.
class TimelineCard extends StatelessWidget {
  /// Creates a [TimelineCard].
  const TimelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    double safeSp(double size) => size.sp > 0 ? size.sp : size;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.std.w,
        vertical: AppSpacing.md.h,
      ),
      padding: EdgeInsets.all(AppSpacing.std.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.radiusLg.r),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeline',
            style: TextStyle(
              fontSize: safeSp(AppFontSize.xl),
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: AppSpacing.std.h),
          _buildSearchField(context, safeSp),
          SizedBox(height: AppSpacing.md.h),
          _buildFilterRow(context, safeSp),
          SizedBox(height: AppSpacing.lg.h),
          BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              final visible = _filter(state);
              if (visible.isEmpty) {
                return _buildEmptyState(safeSp);
              }
              if (state.timelineViewMode == TimelineViewMode.grid) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: visible.length,
                  itemBuilder: (context, index) {
                    return TimelineActivityGridCard(activity: visible[index]);
                  },
                );
              }
              return Column(
                children: [
                  for (var i = 0; i < visible.length; i++) ...[
                    if (i > 0) Divider(height: AppSpacing.lg.h),
                    _buildTimelineRow(context, visible[i], safeSp),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  List<TimelineActivityEntity> _filter(DashboardState state) {
    final query = state.timelineSearch.trim().toLowerCase();
    final now = DateTime.now();
    final list = state.timelineActivities.where((a) {
      switch (state.timelineFilterType) {
        case TimelineFilterType.all:
          return true;
        case TimelineFilterType.overdue:
          return a.dueDate.isBefore(now);
        case TimelineFilterType.next7Days:
          return a.dueDate.isAfter(now) &&
              a.dueDate.isBefore(now.add(const Duration(days: 7)));
        case TimelineFilterType.next30Days:
          return a.dueDate.isAfter(now) &&
              a.dueDate.isBefore(now.add(const Duration(days: 30)));
        case TimelineFilterType.next3Months:
          return a.dueDate.isAfter(now) &&
              a.dueDate.isBefore(now.add(const Duration(days: 90)));
        case TimelineFilterType.next6Months:
          return a.dueDate.isAfter(now) &&
              a.dueDate.isBefore(now.add(const Duration(days: 180)));
      }
    }).toList();
    if (query.isEmpty) return list;
    return list
        .where(
          (a) =>
              a.name.toLowerCase().contains(query) ||
              a.type.toLowerCase().contains(query),
        )
        .toList();
  }

  Widget _buildSearchField(
    BuildContext context,
    double Function(double) safeSp,
  ) {
    final cubit = context.read<DashboardCubit>();
    return BlocBuilder<DashboardCubit, DashboardState>(
      buildWhen: (previous, current) =>
          previous.timelineSearch != current.timelineSearch,
      builder: (context, state) {
        return Container(
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.radiusSm.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              SizedBox(width: AppSpacing.md.w),
              Expanded(
                child: TextField(
                  onChanged: cubit.changeTimelineSearch,
                  style: TextStyle(fontSize: safeSp(AppFontSize.md)),
                  decoration: InputDecoration(
                    hintText: 'Search by activity type or name',
                    hintStyle: TextStyle(
                      color: AppColors.grey600,
                      fontSize: safeSp(AppFontSize.md),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              Icon(
                Icons.search,
                color: AppColors.grey600,
                size: safeSp(AppSize.iconMd - 2),
              ),
              if (state.timelineSearch.isNotEmpty)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => cubit.changeTimelineSearch(''),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
                    child: Icon(
                      Icons.backspace_outlined,
                      color: AppColors.grey600,
                      size: safeSp(AppFontSize.xl),
                    ),
                  ),
                ),
              SizedBox(width: AppSpacing.md.w),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterRow(BuildContext context, double Function(double) safeSp) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      buildWhen: (previous, current) =>
          previous.timelineSortType != current.timelineSortType ||
          previous.timelineFilterType != current.timelineFilterType ||
          previous.timelineViewMode != current.timelineViewMode,
      builder: (context, state) {
        return Row(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: PopupMenuButton<TimelineFilterType>(
                padding: EdgeInsets.zero,
                offset: Offset(0, 40.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusMd.r),
                ),
                onSelected: (TimelineFilterType result) {
                  context
                      .read<DashboardCubit>()
                      .changeTimelineFilterType(result);
                },
                itemBuilder: (BuildContext context) => [
                  _buildFilterMenuItem(
                    TimelineFilterType.all,
                    state.timelineFilterType,
                    safeSp,
                  ),
                  _buildFilterMenuItem(
                    TimelineFilterType.overdue,
                    state.timelineFilterType,
                    safeSp,
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem<TimelineFilterType>(
                    enabled: false,
                    height: 32.h,
                    child: Text(
                      'Due date',
                      style: TextStyle(
                        fontSize: safeSp(AppFontSize.label),
                        color: AppColors.grey600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _buildFilterMenuItem(
                    TimelineFilterType.next7Days,
                    state.timelineFilterType,
                    safeSp,
                  ),
                  _buildFilterMenuItem(
                    TimelineFilterType.next30Days,
                    state.timelineFilterType,
                    safeSp,
                  ),
                  _buildFilterMenuItem(
                    TimelineFilterType.next3Months,
                    state.timelineFilterType,
                    safeSp,
                  ),
                  _buildFilterMenuItem(
                    TimelineFilterType.next6Months,
                    state.timelineFilterType,
                    safeSp,
                  ),
                ],
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.std.w,
                    vertical: AppSpacing.xs.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(AppSize.radiusLg.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.timelineFilterType.label,
                        style: TextStyle(
                          color: AppColors.black87,
                          fontSize: safeSp(AppFontSize.md),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: AppSpacing.xs.w),
                      Icon(
                        Icons.expand_more_rounded,
                        size: safeSp(20),
                        color: AppColors.grey800,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            _buildViewModeToggle(context, state, safeSp),
            SizedBox(width: AppSpacing.xs.w),
            Theme(
              data: Theme.of(context).copyWith(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: PopupMenuButton<TimelineSortType>(
                padding: EdgeInsets.zero,
                offset: Offset(0, 44.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.radiusMd.r),
                ),
                onSelected: (TimelineSortType result) {
                  context.read<DashboardCubit>().changeTimelineSortType(result);
                },
                itemBuilder: (BuildContext context) => [
                  _buildSortMenuItem(
                    TimelineSortType.dates,
                    state.timelineSortType,
                    'Sort by dates',
                    safeSp,
                  ),
                  _buildSortMenuItem(
                    TimelineSortType.courses,
                    state.timelineSortType,
                    'Sort by courses',
                    safeSp,
                  ),
                ],
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm.w,
                    vertical: AppSpacing.xs.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(AppSize.radiusSm.r),
                  ),
                  child: Icon(
                    Icons.sort_rounded,
                    color: AppColors.grey800,
                    size: safeSp(AppSize.iconSmMd),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildViewModeToggle(
    BuildContext context,
    DashboardState state,
    double Function(double) safeSp,
  ) {
    final cubit = context.read<DashboardCubit>();
    final isList = state.timelineViewMode == TimelineViewMode.list;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(AppSize.radiusMd.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildViewModeButton(
            context: context,
            icon: Icons.view_list_rounded,
            isSelected: isList,
            onTap: () => cubit.changeTimelineViewMode(TimelineViewMode.list),
            safeSp: safeSp,
          ),
          _buildViewModeButton(
            context: context,
            icon: Icons.grid_view_rounded,
            isSelected: !isList,
            onTap: () => cubit.changeTimelineViewMode(TimelineViewMode.grid),
            safeSp: safeSp,
          ),
        ],
      ),
    );
  }

  Widget _buildViewModeButton({
    required BuildContext context,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
    required double Function(double) safeSp,
  }) {
    return Material(
      color: isSelected
          ? AppColors.moodleOrange.withValues(alpha: 0.12)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(AppSize.radiusMd.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.radiusMd.r),
        child: Container(
          constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.sm.w,
            vertical: AppSpacing.xs.h,
          ),
          child: Icon(
            icon,
            size: safeSp(AppSize.iconSmMd),
            color: isSelected ? AppColors.moodleOrange : AppColors.grey600,
          ),
        ),
      ),
    );
  }

  PopupMenuItem<TimelineFilterType> _buildFilterMenuItem(
    TimelineFilterType value,
    TimelineFilterType currentSelection,
    double Function(double) safeSp,
  ) {
    final isSelected = value == currentSelection;
    return PopupMenuItem<TimelineFilterType>(
      value: value,
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.std.w,
          vertical: AppSpacing.md.h,
        ),
        color: isSelected ? AppColors.moodleLightOrange : null,
        child: Text(
          value.label,
          style: TextStyle(
            fontSize: safeSp(AppFontSize.md),
            color: AppColors.black87,
          ),
        ),
      ),
    );
  }

  PopupMenuItem<TimelineSortType> _buildSortMenuItem(
    TimelineSortType value,
    TimelineSortType currentSelection,
    String label,
    double Function(double) safeSp,
  ) {
    final isSelected = value == currentSelection;
    return PopupMenuItem<TimelineSortType>(
      value: value,
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.std.w,
          vertical: AppSpacing.md.h,
        ),
        color: isSelected ? AppColors.moodleLightOrange : null,
        child: Text(
          label,
          style: TextStyle(
            fontSize: safeSp(AppFontSize.md),
            color: AppColors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineRow(
    BuildContext context,
    TimelineActivityEntity activity,
    double Function(double) safeSp,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.moodleLightOrange,
            borderRadius: BorderRadius.circular(AppSize.radiusSm.r),
          ),
          child: Icon(
            Icons.assignment_outlined,
            size: safeSp(AppSize.iconMd),
            color: AppColors.moodleOrange,
          ),
        ),
        SizedBox(width: AppSpacing.md.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.name,
                style: TextStyle(
                  fontSize: safeSp(AppFontSize.md),
                  fontWeight: FontWeight.w500,
                  color: AppColors.black87,
                ),
              ),
              SizedBox(height: 2.h),
              Builder(
                builder: (context) {
                  final days =
                      activity.dueDate.difference(DateTime.now()).inDays.abs();
                  return Text(
                    '${activity.type} • due in $days days',
                    style: TextStyle(
                      fontSize: safeSp(AppFontSize.sm),
                      color: AppColors.grey600,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(double Function(double) safeSp) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg.h),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.archive_outlined,
              size: 96.w,
              color: AppColors.grey300,
            ),
            SizedBox(height: AppSpacing.md.h),
            Text(
              'No activities require action',
              style: TextStyle(
                color: AppColors.grey800,
                fontSize: safeSp(AppFontSize.lg),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
