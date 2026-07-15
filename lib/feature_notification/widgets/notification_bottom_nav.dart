import 'package:flutter/material.dart';

class NotificationBottomNav extends StatelessWidget {
  const NotificationBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 3,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      selectedItemColor: const Color(0xffF59E0B),
      unselectedItemColor: Colors.grey,
      elevation: 10,
      onTap: (_) {},
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: "",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat),
          label: "",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          activeIcon: Icon(Icons.notifications, color: Color(0xffF59E0B)),
          label: "",
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          activeIcon: Icon(Icons.more_horiz),
          label: "",
        ),
      ],
    );
  }
}
