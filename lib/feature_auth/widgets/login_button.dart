import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature_auth/cubit/login_cubit.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';

/// A button widget for the Login screen with a loading state.
class LoginButton extends StatelessWidget {
  /// Creates an instance of [LoginButton].
  const LoginButton({
    required this.onPressed,
    super.key,
  });

  /// Callback when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        return SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.moodleButtonOrange,
              foregroundColor: AppTheme.moodleDarkGrey,
              disabledBackgroundColor:
                  AppTheme.moodleButtonOrange.withValues(alpha: 0.6),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: isLoading ? _buildLoading() : _buildText(),
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return const SizedBox(
      height: 18,
      width: 18,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Color(0xFF495057),
      ),
    );
  }

  Widget _buildText() {
    return const Text(
      AppStrings.labelLogin,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
    );
  }
}
