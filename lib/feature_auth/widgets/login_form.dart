import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature_auth/cubit/login_cubit.dart';
import 'package:flutter_boilerplate/feature_auth/widgets/login_button.dart';
import 'package:flutter_boilerplate/feature_auth/widgets/login_text_field.dart';
import 'package:flutter_boilerplate/feature_auth/widgets/lost_password_link.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.ms.w),
          child: Column(
            children: [
              LoginTextField(
                controller: _usernameController,
                label: AppStrings.labelUsername,
              ),
              SizedBox(height: AppSpacing.smm.h),
              LoginTextField(
                controller: _passwordController,
                label: AppStrings.labelPassword,
                isPassword: true,
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xl.h),
        LoginButton(onPressed: _onLoginPressed),
        SizedBox(height: AppSpacing.lg.h),
        const LostPasswordLink(),
      ],
    );
  }

  void _onLoginPressed() {
    context.read<LoginCubit>().login(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
        );
  }
}
