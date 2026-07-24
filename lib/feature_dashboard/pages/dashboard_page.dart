import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature_dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/calendar_card.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/dashboard_bottom_navigation.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/dashboard_header.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/dashboard_tabs.dart';
import 'package:flutter_boilerplate/feature_dashboard/widgets/timeline_card.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The main dashboard page of the application.
class DashboardPage extends StatelessWidget {
  /// Creates a [DashboardPage].
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<DashboardCubit>()..fetchDashboardCourses(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: const DashboardHeader(),
        body: Column(
          children: [
            const DashboardTabs(),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const TimelineCard(),
                    const CalendarCard(),
                    SizedBox(height: 32.h),
                  ],
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
