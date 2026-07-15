import 'package:flutter/material.dart';

/// The screen displaying the course overview, participants, and grades.
class CourseOverviewScreen extends StatelessWidget {
  /// Creates a [CourseOverviewScreen].
  const CourseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.cloud_download_outlined,
                color: Colors.black87,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.black87),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                _buildTabBar(),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildCourseTab(),
                      const Center(child: Text('Participants Placeholder')),
                      const Center(child: Text('Grades Placeholder')),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).size.height * 0.4,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          onPressed: () {},
          child: const Icon(Icons.format_list_bulleted, color: Colors.black87),
        ),
      ),
    );
  }

  /// Builds the header section containing the course image and progress.
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.map, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Celebrating Cultures',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const LinearProgressIndicator(
                          value: 0.27,
                          backgroundColor: Color(0xFFFFE0B2),
                          color: Color(0xFFFF8A22),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      '27%',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the tab bar for Course, Participants, and Grades.
  Widget _buildTabBar() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: const TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.black54,
        indicatorColor: Color(0xFFFF8A22),
        indicatorWeight: 3,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        tabs: [
          Tab(text: 'Course'),
          Tab(text: 'Participants'),
          Tab(text: 'Grades'),
        ],
      ),
    );
  }

  /// Builds the content for the Course tab.
  Widget _buildCourseTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.keyboard_arrow_down, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Welcome! Aloha! Bonvenon!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'We are all from different communities but we are all '
                      'one community at Mount Orange. This course is for '
                      'students, teachers and the wider community '
                      'members to share and learn about our cultural '
                      'diversity.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildVideoPlaceholder(),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade200, height: 1),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.folder_outlined, color: Colors.teal),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Interesting cities',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'No need to download these images - view them',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a placeholder for the video player.
  Widget _buildVideoPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 32,
                color: Colors.black,
              ),
            ),
            const Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Row(
                children: [
                  Text(
                    '0:00 / 0:36',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Spacer(),
                  Icon(Icons.volume_up, color: Colors.white, size: 20),
                  SizedBox(width: 16),
                  Icon(Icons.fullscreen, color: Colors.white, size: 20),
                  SizedBox(width: 16),
                  Icon(Icons.more_vert, color: Colors.white, size: 20),
                ],
              ),
            ),
            Positioned(
              bottom: 32,
              left: 12,
              right: 12,
              child: Container(
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 12,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
