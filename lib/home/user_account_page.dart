import 'package:flutter/material.dart';

/// A static page that displays the user account information and settings.
class UserAccountPage extends StatelessWidget {
  /// Creates a [UserAccountPage].
  const UserAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            // Left Narrow Sidebar
            Container(
              width: 60,
              color: Colors.grey[200],
              child: const Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    'More',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  Icon(Icons.search, color: Colors.black87),
                  SizedBox(height: 24),
                  Icon(Icons.calendar_today, color: Colors.black87),
                  SizedBox(height: 24),
                  Icon(Icons.newspaper, color: Colors.black87),
                  SizedBox(height: 24),
                  Icon(Icons.local_offer, color: Colors.black87),
                  SizedBox(height: 24),
                  Icon(Icons.apps, color: Colors.black87),
                  Spacer(),
                  Icon(Icons.settings, color: Colors.black54),
                  SizedBox(height: 24),
                  Icon(Icons.school, color: Colors.black54),
                  SizedBox(height: 16),
                ],
              ),
            ),
            // Right Main Content Section
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'User account',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(Icons.terrain, size: 40, color: Colors.blue),
                      const Text(
                        'Mount Orange',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'https://school.moodledemo.net',
                        style: TextStyle(fontSize: 12, color: Colors.blue[700]),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    title: const Text(
                      'Barbara Gardner',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView(
                      children: const [
                        _MenuTile(icon: Icons.format_list_bulleted, title: 'Grades'),
                        _MenuTile(icon: Icons.folder_open, title: 'Files'),
                        _MenuTile(icon: Icons.analytics_outlined, title: 'Reports'),
                        _MenuTile(icon: Icons.military_tech, title: 'Badges'),
                        _MenuTile(icon: Icons.article_outlined, title: 'Blog entries'),
                        _MenuTile(icon: Icons.route_outlined, title: 'Learning plans'),
                        _MenuTile(icon: Icons.privacy_tip_outlined, title: 'Data privacy'),
                        _MenuTile(
                          icon: Icons.gavel_outlined,
                          title: 'Policies and agreements',
                        ),
                        _MenuTile(icon: Icons.build_outlined, title: 'Preferences'),
                        _MenuTile(icon: Icons.sync_alt, title: 'Switch account'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[800],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.logout),
                        label: const Text('Log out', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black54),
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          dense: true,
        ),
        const Divider(height: 1, indent: 56),
      ],
    );
  }
}