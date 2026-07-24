import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(2),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lost password?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF212121),
                ),
              ),
              SizedBox(height: .2), // Gap between text and underline
              SizedBox(
                width: 98,
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFF212121),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}