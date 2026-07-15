import 'package:flutter/material.dart';

class TeacherTile extends StatelessWidget {
  const TeacherTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 26),

        const Text(
          'Teachers',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
    );
  }
}
