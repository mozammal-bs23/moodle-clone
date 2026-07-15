import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
const CourseDetailsScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.black45,
body: Stack(
children: [

/// Banner
SizedBox(
width: double.infinity,
height: 270,
child: Image.asset(
'assets/images/course_banner.png',
fit: BoxFit.cover,
),
),

/// Back Button
SafeArea(
child: Padding(
padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
_circleButton(Icons.arrow_back),
_circleButton(Icons.close),
],
),
),
),

/// White Card
Align(
alignment: Alignment.bottomCenter,
child: Container(
height: MediaQuery.of(context).size.height * .68,
width: double.infinity,
decoration: const BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.vertical(
top: Radius.circular(26),
),
),
child: SingleChildScrollView(
padding: const EdgeInsets.all(18),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

const Text(
'Celebrating Cultures',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.w500,
),
),

const SizedBox(height: 10),

Container(
padding: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 6,
),
decoration: BoxDecoration(
color: const Color(0xffFCE5C7),
borderRadius: BorderRadius.circular(20),
),
child: const Text(
'Our Community',
style: TextStyle(
color: Colors.brown,
),
),
),

const SizedBox(height: 22),

Row(
children: [

Expanded(
child: ClipRRect(
borderRadius: BorderRadius.circular(20),
child: const LinearProgressIndicator(
value: .27,
minHeight: 8,
color: Colors.orange,
backgroundColor: Color(0xffFBE5D6),
),
),
),

const SizedBox(width: 10),

const Text(
'27%',
style: TextStyle(
fontWeight: FontWeight.bold,
),
),
],
),

const SizedBox(height: 18),

Container(
padding: const EdgeInsets.all(14),
decoration: BoxDecoration(
color: const Color(0xffF7F7F7),
borderRadius: BorderRadius.circular(10),
),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.calendar_today, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Course start date ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'December 18 2013,\n11:00 PM',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  ),
),

  const SizedBox(height: 24),

  const Text(
    'Course summary',
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),

  const SizedBox(height: 10),

  const Text(
    'An informal, optional module for Mount Orange students, staff and auxiliaries to celebrate and showcase the diversity of our traditions, languages and landscapes.',
    style: TextStyle(
      fontSize: 15,
      height: 1.5,
      color: Colors.black87,
    ),
  ),

  const SizedBox(height: 26),

  const Text(
    'Teachers',
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),

  const SizedBox(height: 12),

  Material(
    color: Colors.transparent,
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        radius: 22,
        backgroundColor: Color(0xffECEFF1),
        child: Text('JS'),
      ),
      title: const Text('Jeffrey Sanders'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    ),
  ),

  const SizedBox(height: 20),
],
),
),
),
),
],
),
);
}

Widget _circleButton(IconData icon) {
  return CircleAvatar(
    radius: 22,
    backgroundColor: Colors.white,
    child: Icon(
      icon,
      color: Colors.black,
      size: 30,
    ),
  );
}
}