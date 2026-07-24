import 'package:flutter/material.dart';

class HelpLink extends StatelessWidget {
  const HelpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(5),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Need help?',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF212121),
                ),
              ),

              SizedBox(height: .5),

              SizedBox(
                width: 72,
                child: Divider(
                  height: .5,
                  thickness: .5,
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
