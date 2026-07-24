import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'login_cubit.freezed.dart';

/// States for the Login process.
@freezed
class LoginState with _$LoginState {
  /// Initial state before any action.
  const factory LoginState.initial() = LoginInitial;

  /// Loading state while authenticating.
  const factory LoginState.loading() = LoginLoading;

  /// Success state after successful login.
  const factory LoginState.success() = LoginSuccess;

  /// Error state with a descriptive message.
  const factory LoginState.error({required String message}) = LoginError;
}

/// Cubit to manage Login logic and state.
///
/// Handles credential validation and simulates the authentication
/// process to the Moodle site.
@injectable
class LoginCubit extends Cubit<LoginState> {
  /// Creates a [LoginCubit] instance.
  LoginCubit() : super(const LoginInitial());

  /// Attempts to log in with the provided credentials.
  ///
  /// Validates that fields are not empty, then simulates a 2-second
  /// network request.
  Future<void> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      emit(const LoginError(
        message: 'Please enter both username and password',
      ));
      return;
    }

    emit(const LoginLoading());

    // Simulation of Moodle authentication delay
    await Future<void>.delayed(const Duration(seconds: 2));

    // For UI demonstration, any credentials will succeed
    emit(const LoginSuccess());
  }

  /// Resets the state to initial.
  void reset() => emit(const LoginInitial());
}
