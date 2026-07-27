import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature_dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/available_courses_card.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/calendar_card.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/dashboard_bottom_navigation.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/dashboard_header.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/dashboard_tabs.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/timeline_card.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/user_account_overlay.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
import 'package:flutter_boilerplate_core/utils/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The main dashboard page of the application.
class DashboardPage extends StatelessWidget {
  /// Creates a [DashboardPage].
  const DashboardPage({super.key});

  void _showUserAccount(BuildContext context) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'UserAccount',
      barrierColor: AppColors.barrier,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: const UserAccountOverlay(),
          ),
        );
      },
      transitionBuilder: (
        BuildContext context,
        Animation<double> anim1,
        Animation<double> anim2,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<DashboardCubit>()..fetchDashboardCourses(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const DashboardHeader(),
        body: Stack(
          children: [
            Column(
              children: [
                const DashboardTabs(),
                Expanded(
                  child: BlocBuilder<DashboardCubit, DashboardState>(
                    builder: (context, state) {
                      return IndexedStack(
                        index: state.selectedTabIndex,
                        children: [
                          // Dashboard Content
                          SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                const TimelineCard(),
                                const CalendarCard(),
                                SizedBox(height: AppSpacing.xl.h),
                              ],
                            ),
                          ),
                          // Site Home Content
                          SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                const AvailableCoursesCard(),
                                SizedBox(height: AppSpacing.xl.h),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            // Floating Right Side Arrow Button
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height * 0.4,
              child: GestureDetector(
                onTap: () => _showUserAccount(context),
                child: Container(
                  width: 40.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.overlayGrey.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.radiusFull.r),
                      bottomLeft: Radius.circular(AppSize.radiusFull.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 4.r,
                        offset: const Offset(-2, 0),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    color: AppColors.black,
                    size: 28.w,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const DashboardBottomNavigation(),
      ),
    );
  }
}
