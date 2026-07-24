import 'package:flutter/material.dart';

class ReconnectOrDivider extends StatelessWidget {
  const ReconnectOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Divider(
            color: Color(0xFFEEEEEE),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF757575),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFEEEEEE),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}