import 'package:flutter/material.dart';

class BaseUrlHeader extends StatelessWidget {
  const BaseUrlHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Connect to Moodle',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF212121),
              letterSpacing: -0.2,
              height: 1.0,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            splashRadius: 18,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            icon: const Icon(
              Icons.settings,
              size: 25,
              color: Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }
}
