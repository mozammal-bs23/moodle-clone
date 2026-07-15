import 'package:flutter/material.dart';

class NotificationHeader extends StatelessWidget {
  const NotificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
                  child: Icon(Icons.person, color: Colors.grey, size: 26),
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
