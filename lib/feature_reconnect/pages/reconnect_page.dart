import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_reconnect/widgets/forgot_password.dart';
import 'package:flutter_boilerplate/feature_reconnect/widgets/login_button.dart';
import 'package:flutter_boilerplate/feature_reconnect/widgets/password_field.dart';
import 'package:flutter_boilerplate/feature_reconnect/widgets/reconnect_header.dart';
import 'package:flutter_boilerplate/feature_reconnect/widgets/reconnect_logo.dart';
import 'package:flutter_boilerplate/feature_reconnect/widgets/reconnect_or_divider.dart';
import 'package:flutter_boilerplate/feature_reconnect/widgets/reconnect_qr_button.dart';
import 'package:flutter_boilerplate/feature_reconnect/widgets/user_avatar.dart';

class ReconnectPage extends StatefulWidget {
  const ReconnectPage({super.key});

  @override
  State<ReconnectPage> createState() => _ReconnectPageState();
}

class _ReconnectPageState extends State<ReconnectPage> {
  bool _hasPassword = false;

  void _onPasswordChanged(String value) {
    final hasPassword = value.trim().isNotEmpty;

    if (_hasPassword != hasPassword) {
      setState(() {
        _hasPassword = hasPassword;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 1.5),

              const ReconnectHeader(),

              const SizedBox(height: 16),

              const ReconnectLogo(),

              const SizedBox(height: 30),

              const UserAvatar(),

              const SizedBox(height: 36),

              PasswordField(
                onChanged: _onPasswordChanged,
              ),

              const SizedBox(height: 28),

              LoginButton(
                isEnabled: _hasPassword,
              ),

              const SizedBox(height: 24),

              const ForgotPassword(),

              const SizedBox(height: 24),

              const ReconnectOrDivider(),

              const SizedBox(height: 20),

              const ReconnectQrButton(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}