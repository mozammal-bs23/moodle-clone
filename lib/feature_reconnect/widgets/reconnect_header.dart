import 'package:flutter/material.dart';

class ReconnectHeader extends StatelessWidget {
  const ReconnectHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            icon: const Icon(
              Icons.arrow_back,
              size: 22,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(width: 20),
          const Text(
            'Reconnect',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
              letterSpacing: -0.2,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            icon: const Icon(
              Icons.help_outline,
              size: 22,
              color: Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }
}