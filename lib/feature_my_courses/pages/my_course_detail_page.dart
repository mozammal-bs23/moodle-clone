import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_boilerplate/feature_my_courses/cubit/course_contents_cubit.dart';
import 'package:flutter_boilerplate/feature_my_courses/cubit/my_courses_state.dart';
import 'package:flutter_boilerplate/feature_my_courses/widgets/course_contents_list.dart';
import 'package:flutter_boilerplate/feature_my_courses/widgets/course_index_drawer.dart';
import 'package:flutter_boilerplate/src/injection/di.dart';

/// Full-screen detail view for a single enrolled course.
///
/// Layout matches the real Moodle mobile app:
///   * Small AppBar (back, cloud-download, info) — no title in the bar.
///   * Header row: square avatar tile + course title + "Category 1"
///     pill.
///   * "Grades | Competencies" sub-tab strip with a back-chevron on
///     the left. (Both tabs are visual placeholders for now.)
///   * Course Contents sections (collapsible, anchored) underneath.
///   * A floating ⋮ button in the bottom-right opens the Course Index
///     drawer.
class MyCourseDetailPage extends StatefulWidget {
  /// Creates a [MyCourseDetailPage]. [course] may be null when the page
  /// is opened without a payload.
  const MyCourseDetailPage({super.key, required this.course});

  /// The course to display, or null when none was supplied.
  final MyCourseItem? course;

  @override
  State<MyCourseDetailPage> createState() => _MyCourseDetailPageState();
}

class _MyCourseDetailPageState extends State<MyCourseDetailPage> {
  /// Anchor to the contents list so the FAB / drawer can scroll into
  /// view via the public [scrollToAnchor] hook.
  final GlobalKey<CourseContentsListState> _contentsKey =
      GlobalKey<CourseContentsListState>();

  void _scrollToAnchor(String id) {
    final state = _contentsKey.currentState;
    if (state == null) return;
    state.scrollToAnchor(id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? theme.colorScheme.surface : Colors.white;

    final course = widget.course;
    if (course == null) {
      return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(title: const Text('Course')),
        body: const Center(
          child: Text('Course not found.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bg,
      // Course Contents is the page's default body — the
      // Grades | Competencies strip below the header is decorative
      // (both tabs are placeholders), it doesn't actually swap the
      // body. This mirrors the real Moodle app, where "Course
      // contents" is the page itself and the Grades/Competencies
      // strip is a sub-nav.
      body: DefaultTabController(
        length: 2,
        child: BlocProvider<CourseContentsCubit>(
          create: (_) => getIt<CourseContentsCubit>()
            ..load(int.tryParse(course.id) ?? 0),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomScrollView(
                  // Plain (non-nested) scroll view — CourseContentsList
                  // returns a SliverList, which fits directly into a
                  // CustomScrollView. Pinning the AppBar and the
                  // Grades/Competencies strip keeps the chrome visible
                  // while the contents scroll.
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: bg,
                      foregroundColor: theme.colorScheme.onSurface,
                      elevation: 0,
                      scrolledUnderElevation: 0.5,
                      titleSpacing: 0,
                      title: const SizedBox.shrink(),
                      actions: [
                        IconButton(
                          tooltip: 'Download course',
                          icon: const Icon(Icons.cloud_download_outlined),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Download not implemented yet.',
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          tooltip: 'Course info',
                          icon: const Icon(Icons.info_outline),
                          onPressed: () =>
                              _showCourseInfoSheet(context, course),
                        ),
                        const SizedBox(width: 4),
                      ],
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () =>
                            Navigator.of(context).maybePop(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _HeaderRow(course: course),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _TabBarDelegate(
                        bg: bg,
                        theme: theme,
                        tabBar: TabBar(
                          labelColor: theme.colorScheme.onSurface,
                          unselectedLabelColor:
                              theme.colorScheme.onSurfaceVariant,
                          indicatorColor: const Color(0xFFF08C2E),
                          indicatorWeight: 3,
                          labelStyle:
                              theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          tabs: const [
                            Tab(text: 'Grades'),
                            Tab(text: 'Competencies'),
                          ],
                        ),
                      ),
                    ),
                    // SliverList produced by the contents widget (returns
                    // its own SliverList).
                    CourseContentsList(key: _contentsKey),
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 96),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16.w,
                bottom: 24.h,
                child: FloatingActionButton(
                  heroTag: 'course-index-fab',
                  onPressed: () => _openCourseIndex(context),
                  backgroundColor: Colors.white,
                  foregroundColor: theme.colorScheme.onSurface,
                  elevation: 4,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.format_list_bulleted_rounded,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openCourseIndex(BuildContext context) {
    // Read the current sections straight from the cubit (we have it
    // through the BlocBuilder above, but a fresh context.read keeps
    // this method independent of the build phase).
    final state = context.read<CourseContentsCubit>().state;
    if (state.sections.isEmpty) return;
    CourseIndexDrawer.show(
      context,
      sections: state.sections,
      onTapAnchor: _scrollToAnchor,
      // First section is the default active one (matches the screenshot
      // where "General" is highlighted).
      activeSectionId: state.sections.first.id,
    );
  }

  void _showCourseInfoSheet(BuildContext context, MyCourseItem course) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: Theme.of(sheetContext).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              if (course.category.isNotEmpty)
                Text('Category: ${course.category}'),
              if (course.startDate != null)
                Text('Starts: ${_formatDate(course.startDate!)}'),
              if (course.endDate != null)
                Text('Ends: ${_formatDate(course.endDate!)}'),
              if (course.progress != null)
                Text('Progress: ${(course.progress! * 100).round()}%'),
            ],
          ),
        ),
      ),
    );
  }

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static String _formatDate(DateTime d) =>
      '${_months[d.month - 1]} ${d.day}, ${d.year}';
}

/// Top header row: avatar tile + course title + category pill.
class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.course});

  final MyCourseItem course;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Color(course.colorSeed),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.school_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5E6DA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    course.category.isEmpty ? 'Course' : course.category,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8B5A3C),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pinned tab strip below the header. Wraps [TabBar] in a
/// [SliverPersistentHeader] so it stays visible when the user scrolls
/// the Course tab body.
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  _TabBarDelegate({
    required this.bg,
    required this.theme,
    required this.tabBar,
  });

  final Color bg;
  final ThemeData theme;
  final TabBar tabBar;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isDark = theme.brightness == Brightness.dark;
    final borderColor =
        isDark ? const Color(0xFF2A2A2E) : const Color(0xFFE5E7EB);
    return Container(
      color: bg,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded),
                  color: theme.colorScheme.onSurfaceVariant,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
                Expanded(child: tabBar),
                const SizedBox(width: 8),
              ],
            ),
          ),
          Divider(height: 1, color: borderColor),
        ],
      ),
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height + 1;

  @override
  double get minExtent => tabBar.preferredSize.height + 1;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) => false;
}
