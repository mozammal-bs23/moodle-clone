import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/constants/app_strings.dart';
import 'package:flutter_boilerplate/feature_course/logic/course_overview_controller.dart';
import 'package:flutter_boilerplate/feature_course/models/course_model.dart';
import 'package:flutter_boilerplate/feature_course/widgets/course_content_card.dart';
import 'package:flutter_boilerplate/feature_course/widgets/course_header_widget.dart';

/// The screen displaying the course overview.
class CourseOverviewScreen extends StatefulWidget {
  /// Creates a [CourseOverviewScreen].
  const CourseOverviewScreen({super.key});

  @override
  State<CourseOverviewScreen> createState() => _CourseOverviewScreenState();
}

class _CourseOverviewScreenState extends State<CourseOverviewScreen> {
  final CourseOverviewController _controller = CourseOverviewController();

  @override
  void initState() {
    super.initState();
    _controller.fetchCourseData('1');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            // Placeholder: Does nothing when clicked
            onPressed: () {},
          ),
          actions: const [
            Icon(Icons.cloud_download),
            SizedBox(width: 16),
            Icon(Icons.info_outline),
            SizedBox(width: 16),
          ],
          // Header and Tabs inside AppBar to match reference
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(160),
            child: Column(
              children: [
                CourseHeaderWidget(progress: _controller.progress),
                TabBar(
                  indicatorColor: theme.colorScheme.primary,
                  labelColor: theme.colorScheme.onSurface,
                  tabs: const [
                    Tab(text: AppStrings.course),
                    Tab(text: AppStrings.participants),
                    Tab(text: AppStrings.grades),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            if (_controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final course = _controller.courseData ?? const CourseModel(
              title: 'Celebrating Cultures',
              description: 'We are all from different communities...',
            );

            return TabBarView(
              children: [
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    CourseContentCard(
                      title: course.title,
                      description: course.description,
                      isExpanded: _controller.isExpanded,
                      onExpansionChanged: (_) => _controller.toggleExpanded(),
                    ),
                  ],
                ),
                const Center(child: Text('Participants')),
                const Center(child: Text('Grades')),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(), // Forces circular shape
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          child: Icon(
            Icons.list,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
