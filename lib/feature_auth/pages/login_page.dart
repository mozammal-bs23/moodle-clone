import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature_auth/cubit/login_cubit.dart';
import 'package:flutter_boilerplate/feature_auth/widgets/login_form.dart';
import 'package:flutter_boilerplate/feature_auth/widgets/login_header.dart';
import 'package:flutter_boilerplate/routes/app_routes.dart';
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Pixel-perfect Login Page for the Moodle Clone application.
class LoginPage extends StatelessWidget {
  /// Creates an instance of [LoginPage].
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _LoginPageScaffold(),
    );
  }
}

/// Internal scaffold widget for the [LoginPage] to access the [LoginCubit].
class _LoginPageScaffold extends StatelessWidget {
  /// Creates an instance of [_LoginPageScaffold].
  const _LoginPageScaffold();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () => context.go(AppRoutes.posts),
          error: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
            child: Column(
              children: [
                // Slightly increased gap between AppBar and Logo
                SizedBox(height: AppSpacing.sm.h),
                const LoginHeader(),
                // Shifted form further upward for pixel-perfect ratio
                SizedBox(height: AppSpacing.lg.h),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the pixel-perfect AppBar matching the reference screenshot.
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onSurface,
          size: AppSize.iconMd.r,
        ),
        onPressed: () {},
      ),
      title: Text(
        AppStrings.labelLogin,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w500,
          fontSize: 19.sp,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).colorScheme.onSurface,
            size: AppSize.iconMd.r,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.help_outline,
            color: Theme.of(context).colorScheme.onSurface,
            size: AppSize.iconMd.r,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
