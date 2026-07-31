import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/src/injection/di.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_boilerplate/feature_my_courses/cubit/my_courses_cubit.dart';
import 'package:flutter_boilerplate/feature_my_courses/cubit/my_courses_state.dart';
import 'package:flutter_boilerplate/feature_my_courses/utils/my_courses_strings.dart';
import 'package:flutter_boilerplate/feature_my_courses/widgets/my_course_card.dart';
import 'package:flutter_boilerplate/feature_my_courses/widgets/my_courses_bottom_nav.dart';
import 'package:flutter_boilerplate/feature_my_courses/widgets/my_courses_filter_row.dart';
import 'package:flutter_boilerplate/feature_my_courses/widgets/my_courses_site_header.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';

/// My Courses page.
///
/// Layout (matches the target design):
///   • Site header: site name + user avatar.
///   • Page title "My courses".
///   • Filter row: search input, status dropdown, sort + grid icons.
///   • Body: list of course cards (or loading / error view).
///   • Bottom navigation bar with 5 tabs (Courses active).
class MyCoursesPage extends StatelessWidget {
  const MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyCoursesCubit>(
      // Resolve the cubit from the global service locator — the DI graph
      // wires it up with the GetMyCoursesUseCase + repository at startup.
      create: (_) => getIt<MyCoursesCubit>()..fetchCourses(),
      child: const _MyCoursesPageView(),
    );
  }
}

class _MyCoursesPageView extends StatelessWidget {
  const _MyCoursesPageView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Use pure white in light mode to match the design asset; fall back
    // to the theme surface in dark mode.
    final bg = isDark ? theme.colorScheme.surface : Colors.white;
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            const MyCoursesSiteHeader(),
            const _PageTitle(),
            const MyCoursesFilterRow(),
            Expanded(
              child: BlocBuilder<MyCoursesCubit, MyCoursesState>(
                builder: (context, state) => _Body(state: state),
              ),
            ),
            MyCoursesBottomNav(
              currentTab: MyCoursesNavTab.courses,
              onTabSelected: (_) {
                // Other tabs will be wired up in their own feature
                // branches. For now we keep the user on this page.
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 12.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          MyCoursesStrings.pageTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final MyCoursesState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const _LoadingView();
    }
    if (state.errorMessage != null) {
      return _ErrorView(message: state.errorMessage!);
    }
    return _CoursesList(
      courses: state.visibleCourses,
      viewMode: state.viewMode,
    );
  }
}

class _CoursesList extends StatelessWidget {
  const _CoursesList({required this.courses, required this.viewMode});

  final List<MyCourseItem> courses;
  final MyCoursesViewMode viewMode;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      // Per the target design, the empty state is just the filter row
      // — no illustration, no CTA. We still need a scrollable region
      // under the filter row so RefreshIndicator works.
      return ListView(
        key: const ValueKey<String>('my-courses-empty-list'),
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [SizedBox(height: 80)],
      );
    }
    // Single widget swap slot: both branches produce a scrollable
    // wrapping `MyCourseCard`s so Flutter's element diff doesn't
    // choke on changing the runtime widget type.
    return RefreshIndicator(
      onRefresh: () => context.read<MyCoursesCubit>().refreshCourses(),
      child: _CoursesScroller(
        // Re-key on viewMode so the scrollable is rebuilt cleanly
        // when switching between list and grid layouts.
        key: ValueKey<String>('my-courses-scroller-${viewMode.name}'),
        viewMode: viewMode,
        courses: courses,
      ),
    );
  }
}

class _CoursesScroller extends StatelessWidget {
  const _CoursesScroller({
    super.key,
    required this.viewMode,
    required this.courses,
  });

  final MyCoursesViewMode viewMode;
  final List<MyCourseItem> courses;

  /// Handles taps from the card's overflow menu.
  ///
  /// Each action currently surfaces a snackbar so the user gets
  /// immediate feedback. When the underlying Moodle endpoint is wired
  /// up (e.g. `core_course_view` for download, a favourites endpoint
  /// for the star), the snackbar text is swapped for the real call.
  void _handleMenuAction(
    BuildContext context,
    MyCourseItem course,
    MyCourseCardMenuAction action,
  ) {
    final messenger = ScaffoldMessenger.of(context);
    final String message = switch (action) {
      MyCourseCardMenuAction.download =>
        MyCoursesStrings.cardActionDownloadPending,
      MyCourseCardMenuAction.remove =>
        MyCoursesStrings.cardActionRemovePending,
      MyCourseCardMenuAction.favourite =>
        MyCoursesStrings.cardActionFavouritePending,
    };
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final cardFor = (BuildContext ctx, MyCourseItem course) => MyCourseCard(
          course: course,
          onTap: () => ctx.push(AppRoutes.courseDetail, extra: course),
          onMenuAction: (action) => _handleMenuAction(ctx, course, action),
        );

    switch (viewMode) {
      case MyCoursesViewMode.list:
        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          itemCount: courses.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) => cardFor(context, courses[index]),
        );
      case MyCoursesViewMode.grid:
        return GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            // ~0.85 keeps cells tall enough to fit avatar (48) +
            // 2-line title + category pill without overflowing on a
            // 360 dp wide phone.
            childAspectRatio: 0.85,
          ),
          itemCount: courses.length,
          itemBuilder: (context, index) => cardFor(context, courses[index]),
        );
    }
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        SizedBox(height: 120),
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 12),
        Center(child: Text(MyCoursesStrings.loading)),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: theme.colorScheme.error,
          ),
          SizedBox(height: 12.h),
          Text(
            MyCoursesStrings.errorTitle,
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 24.h),
          FilledButton.icon(
            onPressed: () => context.read<MyCoursesCubit>().fetchCourses(),
            icon: const Icon(Icons.refresh),
            label: const Text(MyCoursesStrings.errorRetry),
          ),
        ],
      ),
    );
  }
}