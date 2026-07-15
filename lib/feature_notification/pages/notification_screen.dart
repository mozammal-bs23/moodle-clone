import 'package:flutter/material.dart';
import '../widgets/notification_bottom_nav.dart';
import '../widgets/notification_header.dart';
import '../widgets/notification_item.dart';
import '../widgets/mark_read_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const NotificationHeader(),

                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: const [NotificationItem(), SizedBox(height: 120)],
                  ),
                ),
              ],
            ),

            const MarkReadButton(),
          ],
        ),
      ),

      bottomNavigationBar: const NotificationBottomNav(),
    );
  }
}
