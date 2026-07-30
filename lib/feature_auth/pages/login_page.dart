import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/feature_auth/cubit/login_cubit.dart';
import 'package:flutter_boilerplate/feature_auth/pages/login_page_scaffold.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;

/// Pixel-perfect Login Page for the Moodle Clone application.
///
/// Responsibility is intentionally narrow: resolve the [LoginCubit] from
/// the service locator (so its constructor dependencies — including
/// [LoginUseCase] — are satisfied via the manual DI wiring in
/// `lib/src/injection/di.dart`) and mount the [LoginPageScaffold].
///
/// Visual layout, app bar, and bloc state handling live in
/// `login_page_scaffold.dart`.
class LoginPage extends StatelessWidget {
  /// Creates an instance of [LoginPage].
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.getIt<LoginCubit>(),
      child: const LoginPageScaffold(),
    );
  }
}
