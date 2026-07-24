import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature_auth/cubit/login_cubit.dart';
import 'package:flutter_boilerplate/feature_auth/widgets/login_button.dart';
import 'package:flutter_boilerplate/feature_auth/widgets/login_text_field.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A widget that provides the authentication input fields and login button.
class LoginForm extends StatefulWidget {
  /// Creates an instance of [LoginForm].
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              LoginTextField(
                controller: _usernameController,
                label: AppStrings.labelUsername,
              ),
              const SizedBox(height: 14),
              LoginTextField(
                controller: _passwordController,
                label: AppStrings.labelPassword,
                isPassword: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        LoginButton(onPressed: _onLoginPressed),
        const SizedBox(height: 24),
        _buildLostPasswordLink(),
      ],
    );
  }

  void _onLoginPressed() {
    context.read<LoginCubit>().login(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
        );
  }

  Widget _buildLostPasswordLink() {
    return InkWell(
      onTap: () {},
      child: const Text(
        AppStrings.labelLostPassword,
        style: TextStyle(
          color: AppTheme.moodleLinkGrey,
          decoration: TextDecoration.underline,
          decorationThickness: 1.2,
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
