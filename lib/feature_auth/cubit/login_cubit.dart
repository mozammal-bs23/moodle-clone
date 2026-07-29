import 'package:bloc/bloc.dart';
import 'package:flutter_boilerplate/feature_auth/domain/entities/login_token_entity.dart';
import 'package:flutter_boilerplate/feature_auth/domain/usecases/login_usecase.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
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

  /// Success state after a valid Moodle login response.
  ///
  /// Parameterless on purpose: the existing `LoginPage` consumes this state
  /// as `state.whenOrNull(success: () => context.go(AppRoutes.posts))`. The
  /// obtained [LoginTokenEntity] is persisted to [LocalStorage] before this
  /// state is emitted so subsequent requests can authenticate via
  /// [AuthInterceptor].
  const factory LoginState.success() = LoginSuccess;

  /// Error state with a descriptive message.
  const factory LoginState.error({required String message}) = LoginError;
}

/// Cubit to manage Login logic and state.
///
/// Orchestrates the login flow:
///   1. Validate that the credentials are non-empty.
///   2. Emit [LoginLoading].
///   3. Delegate the actual network call to [LoginUseCase], which in turn
///      delegates to `LoginRepository`.
///   4. Persist the returned token (when present) under
///      [AppConstants.tokenKey] so the [AuthInterceptor] can attach it as
///      `Bearer` on subsequent requests.
///   5. Emit [LoginSuccess] or [LoginError] depending on the [Result].
@injectable
class LoginCubit extends Cubit<LoginState> {
  /// Creates a [LoginCubit].
  ///
  /// [loginUseCase] is normally resolved by [di.getIt]; the constructor
  /// stays explicit so the cubit can be unit-tested with a mocked use case.
  LoginCubit({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(const LoginInitial());

  final LoginUseCase _loginUseCase;

  /// Attempts to log in with the provided credentials.
  ///
  /// [username] and [password] are forwarded as-is — the presentation layer
  /// is responsible for trimming/normalizing user input before calling.
  Future<void> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      emit(const LoginError(message: _errorEmptyCredentials));
      return;
    }

    emit(const LoginLoading());

    final (token, failure) =
        await _loginUseCase(username: username, password: password);

    if (failure != null) {
      emit(LoginError(message: failure.message));
      return;
    }

    await _persistToken(token);

    emit(const LoginSuccess());
  }

  /// Persists the obtained token (if any) to [LocalStorage] under
  /// [AppConstants.tokenKey] so the next session starts authenticated.
  ///
  /// Persistence is best-effort: a storage failure is intentionally
  /// swallowed here because the user has already authenticated and we'd
  /// rather complete the navigation than show a confusing error screen for
  /// a failed cache write.
  Future<void> _persistToken(LoginTokenEntity? token) async {
    if (token == null) return;
    await di.getIt<LocalStorage>().set<String>(
          AppConstants.tokenKey,
          token.token,
        );
  }

  /// Resets the state to initial.
  void reset() => emit(const LoginInitial());
}

/// Error message shown when the user submits the login form with one or
/// both credentials missing.
///
/// Local to this feature because `core/` is shared with the rest of the
/// app and adding a single-use string there would widen the package's
/// public surface for no gain.
const String _errorEmptyCredentials =
    'Please enter both username and password';
