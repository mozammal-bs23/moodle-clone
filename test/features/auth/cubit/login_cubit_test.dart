import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_boilerplate/feature_auth/cubit/login_cubit.dart';
import 'package:flutter_boilerplate/feature_auth/cubit/login_state.dart';
import 'package:flutter_boilerplate/feature_auth/data/repositories/login_auth_messages.dart';
import 'package:flutter_boilerplate/feature_auth/domain/entities/login_token_entity.dart';
import 'package:flutter_boilerplate/feature_auth/domain/usecases/login_usecase.dart';
import 'package:flutter_boilerplate/src/injection/di.dart' as di;
import 'package:flutter_boilerplate_core/flutter_boilerplate_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_cubit_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late MockLoginUseCase useCase;

  setUp(() {
    useCase = MockLoginUseCase();
    // The cubit reaches into `getIt` to obtain LocalStorage when
    // persisting a successful token. The test for the success path needs
    // a registered LocalStorage; for the empty-credentials tests this
    // branch is never reached, but registering it unconditionally keeps
    // the setUp simple.
    if (di.getIt.isRegistered<LocalStorage>()) {
      di.getIt.unregister<LocalStorage>();
    }
    di.getIt.registerSingleton<LocalStorage>(_FakeLocalStorage());
  });

  tearDown(() async {
    if (di.getIt.isRegistered<LocalStorage>()) {
      di.getIt.unregister<LocalStorage>();
    }
  });

  /// Records each state the cubit transitions through into [out].
  ///
  /// `Cubit.stream` is a broadcast stream that emits every state the
  /// cubit transitions through, including the initial `LoginInitial`
  /// (synchronously delivered to the listener on subscription). The
  /// listener is attached *before* `cubit.login(...)` is called, so
  /// `emitted` captures the full sequence of post-subscription states.
  StreamSubscription<LoginState> recordStates(
    Cubit<LoginState> cubit,
    List<LoginState> out,
  ) =>
      cubit.stream.listen(out.add);

  group('LoginCubit.login — empty credentials', () {
    test('emits LoginInitial then LoginError on the first empty attempt',
        () async {
      final cubit = LoginCubit(loginUseCase: useCase);
      final emitted = <LoginState>[];
      final sub = recordStates(cubit, emitted);

      await cubit.login(username: '', password: '');

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      // The first entry is the synchronous initial state delivered to
      // the listener on subscription; the second is the validation
      // error. The LoginInitial "reset" emit inside
      // _emitValidationError is dedup'd by bloc (state already equals
      // LoginInitial) and is intentionally not surfaced.
      expect(emitted, [
        const LoginInitial(),
        const LoginError(message: loginEmptyCredentialsMessage),
      ]);
      expect(cubit.state, isA<LoginError>());
    });

    test('emits LoginError on the SECOND empty attempt — regression '
        'test for the duplicate SnackBar bug', () async {
      final cubit = LoginCubit(loginUseCase: useCase);
      final emitted = <LoginState>[];
      final sub = recordStates(cubit, emitted);

      // First attempt → LoginError emitted.
      await cubit.login(username: '', password: '');
      // Second attempt on the same empty form MUST produce a fresh
      // LoginError emission. Without the LoginInitial reset inside
      // _emitValidationError, bloc would deduplicate the second
      // LoginError (state didn't change) and only the first emission
      // would arrive in the stream — the SnackBar would only show
      // once.
      await cubit.login(username: '', password: '');

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      final loginEmptyCredErrors = emitted
          .whereType<LoginError>()
          .where((e) => e.message == loginEmptyCredentialsMessage)
          .toList();

      expect(loginEmptyCredErrors.length, 2,
          reason: 'SnackBar must fire on every empty-attempt, not just '
              'the first; without _emitValidationError resetting to '
              'LoginInitial, bloc would suppress the second emission.');
    });

    test('emits LoginError on every subsequent empty attempt, not just '
        'the first', () async {
      final cubit = LoginCubit(loginUseCase: useCase);
      final emitted = <LoginState>[];
      final sub = recordStates(cubit, emitted);

      await cubit.login(username: '', password: '');
      await cubit.login(username: '', password: '');
      await cubit.login(username: '', password: '');

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      final loginEmptyCredErrors = emitted
          .whereType<LoginError>()
          .where((e) => e.message == loginEmptyCredentialsMessage)
          .toList();

      expect(loginEmptyCredErrors.length, 3);
    });
  });

  group('LoginCubit.login — successful login', () {
    test('emits LoginLoading then LoginSuccess', () async {
      when(useCase(username: 'student', password: 'Student@123')).thenAnswer(
        (_) async => (const LoginTokenEntity(token: 'public-token-abc'), null),
      );

      final cubit = LoginCubit(loginUseCase: useCase);
      final emitted = <LoginState>[];
      final sub = recordStates(cubit, emitted);

      await cubit.login(username: 'student', password: 'Student@123');

      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(emitted, [
        const LoginLoading(),
        const LoginSuccess(),
      ]);
      verify(useCase(username: 'student', password: 'Student@123'))
          .called(1);
    });
  });
}

/// No-op LocalStorage for tests — the cubit only calls `.set` on it, so
/// we return a successful Result without actually persisting anything.
class _FakeLocalStorage implements LocalStorage {
  @override
  Future<Result<T?>> get<T>(String key) async => (null, null);

  @override
  Future<Map<String, dynamic>> getAll() async => {};

  @override
  Future<Result<bool>> set<T>(String key, T value) async => (true, null);

  @override
  Future<Result<bool>> remove(String key) async => (true, null);

  @override
  Future<Result<bool>> clear() async => (true, null);

  @override
  Future<bool> containsKey(String key) async => false;

  @override
  Future<Set<String>> getKeys() async => {};

  @override
  Future<void> dispose() async {}
}
