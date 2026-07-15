import 'package:flutter/material.dart';

class MarkReadButton extends StatelessWidget {
  const MarkReadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 95,
      left: 0,
      right: 0,
      child: Center(
        child: SizedBox(
          width: 180,
          height: 42,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.visibility_outlined, size: 20),
            label: const Text(
              'Mark all as read',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              elevation: 5,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
