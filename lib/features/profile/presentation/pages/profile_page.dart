import 'package:flutter/material.dart';

/// Profile page placeholder
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(
        child: Text('Profile Page - Implement your profile UI here'),
      ),
    );
  }
}
