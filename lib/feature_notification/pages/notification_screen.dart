import 'package:flutter/material.dart';

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

/// Header
Padding(
padding: const EdgeInsets.symmetric(
horizontal: 20,
vertical: 18,
),
child: Row(
children: [

const Expanded(
child: Text(
"Notifications",
style: TextStyle(
fontSize: 30,
fontWeight: FontWeight.bold,
color: Colors.black,
),
),
),

InkWell(
onTap: () {},
borderRadius: BorderRadius.circular(30),
child: const CircleAvatar(
radius: 20,
backgroundColor: Color(0xffECECEC),
child: Icon(
Icons.person,
color: Colors.grey,
size: 26,
),
),
),
],
),
),

const Divider(
height: 1,
thickness: 1,
),

Expanded(
child: ListView(
padding: EdgeInsets.zero,
children: [

Padding(
padding: const EdgeInsets.symmetric(
horizontal: 20,
vertical: 20,
),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Container(
width: 50,
height: 50,
decoration: BoxDecoration(
color: const Color(0xffF3F5F7),
borderRadius:
BorderRadius.circular(25),
),
child: const Icon(
Icons.login,
color: Color(0xff1F2937),
),
),

const SizedBox(width: 16),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Row(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Expanded(
child: RichText(
text: const TextSpan(
style: TextStyle(
color: Colors.black,
fontSize: 16,
),
children: [

TextSpan(
text:
"New sign in to your ",
),

TextSpan(
text: "Mount Orange",
style: TextStyle(
fontWeight:
FontWeight.bold,
),
),

TextSpan(
text: " account",
),
],
),
),
),

const SizedBox(width: 10),

Container(
width: 10,
height: 10,
decoration:
const BoxDecoration(
color: Color(0xffF59E0B),
shape: BoxShape.circle,
),
),
],
),

const SizedBox(height: 8),

const Text(
"47 min ago",
style: TextStyle(
color: Colors.grey,
fontSize: 13,
),
),
],
),
),
],
),
),

const Divider(
height: 1,
indent: 86,
),
  const SizedBox(height: 120),
],
),
),
],
),

  /// Mark all as read button
  Positioned(
    bottom: 95,
    left: 0,
    right: 0,
    child: Center(
      child: SizedBox(
        width: 180,
        height: 42,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.visibility_outlined,
            size: 20,
          ),
          label: const Text(
            'Mark all as read',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1976D2),
            foregroundColor: Colors.white,
            elevation: 5,
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
        ),
      ),
    ),
  ),
],
),
),

  bottomNavigationBar: BottomNavigationBar(
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
        activeIcon: Icon(
          Icons.notifications,
          color: Color(0xffF59E0B),
        ),
        label: "",
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.more_horiz),
        activeIcon: Icon(Icons.more_horiz),
        label: "",
      ),
    ],
  ),
);
}
}