import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/error_boundary/error_boundary_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

/// Mutable flag used by [_ConditionalErrorWidget] to control whether its
/// next `build()` call reports a synchronous error via [FlutterError.onError],
/// mirroring how the framework reports a synchronous build-time exception
/// (e.g. one thrown while `ScreenUtilInit` or a descendant is building).
class _ErrorFlag {
  _ErrorFlag({this.value = false});

  bool value;
}

/// A widget that, when [flag.value] is true, synchronously invokes the
/// currently installed [FlutterError.onError] handler from *within its own
/// build() call* -- i.e. while the framework's build phase is still locked.
/// This faithfully reproduces the reported crash scenario without depending
/// on Flutter's internal build-error double-reporting chain.
class _ConditionalErrorWidget extends StatelessWidget {
  const _ConditionalErrorWidget(this.flag);

  final _ErrorFlag flag;

  @override
  Widget build(BuildContext context) {
    if (flag.value) {
      FlutterError.onError?.call(
        FlutterErrorDetails(
          exception: Exception('Simulated synchronous build-time error'),
          stack: StackTrace.current,
        ),
      );
    }
    return const Text('child rendered');
  }
}

/// Wraps [child] the same way `MyApp` wraps its content in `lib/main.dart`:
/// `ErrorBoundary` around `ScreenUtilInit` around a `MaterialApp`.
Widget _wrap(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, _) => MaterialApp(home: child),
  );
}

void main() {
  group('ErrorBoundary', () {
    testWidgets(
      'renders child normally when no error occurs '
      '[SHOULD PASS - happy path]',
      (tester) async {
        final flag = _ErrorFlag();

        await tester.pumpWidget(
          _wrap(ErrorBoundary(child: _ConditionalErrorWidget(flag))),
        );

        expect(find.text('child rendered'), findsOneWidget);
        expect(find.byType(ErrorScreen), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'does not throw "setState() or markNeedsBuild() called during build" '
      'when an error is reported synchronously while a descendant is '
      'building, and shows the fallback ErrorScreen '
      '[SHOULD FAIL before fix - SHOULD PASS after fix]',
      (tester) async {
        final flag = _ErrorFlag(value: true);

        // With the buggy implementation, _setError() calls setState()
        // synchronously from inside FlutterError.onError while the build
        // phase for this frame is still locked (ScreenUtilInit/descendant
        // build in progress) -- this throws a FlutterError and the pump
        // (and thus this test) fails right here.
        await tester.pumpWidget(
          _wrap(ErrorBoundary(child: _ConditionalErrorWidget(flag))),
        );

        // Let the deferred setState (scheduled via addPostFrameCallback)
        // run and trigger the rebuild that shows the fallback UI.
        await tester.pump();

        expect(find.byType(ErrorScreen), findsOneWidget);
        expect(find.text('child rendered'), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'still invokes widget.onError with the original error when an error '
      'is reported synchronously during build '
      '[SHOULD PASS - regression guard]',
      (tester) async {
        final flag = _ErrorFlag(value: true);
        Object? capturedError;
        StackTrace? capturedStack;

        await tester.pumpWidget(
          _wrap(
            ErrorBoundary(
              onError: (error, stack) {
                capturedError = error;
                capturedStack = stack;
              },
              child: _ConditionalErrorWidget(flag),
            ),
          ),
        );
        await tester.pump();

        expect(capturedError, isNotNull);
        expect(
          capturedError.toString(),
          contains('Simulated synchronous build-time error'),
        );
        expect(capturedStack, isNotNull);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'allows retrying via the ErrorScreen "Try Again" button after an '
      'error was caught, returning to the child UI '
      '[SHOULD PASS - regression guard]',
      (tester) async {
        final flag = _ErrorFlag(value: true);

        await tester.pumpWidget(
          _wrap(ErrorBoundary(child: _ConditionalErrorWidget(flag))),
        );
        await tester.pump();

        expect(find.byType(ErrorScreen), findsOneWidget);

        // Stop the child from throwing again, then retry.
        flag.value = false;
        await tester.tap(find.widgetWithText(ElevatedButton, 'Try Again'));
        await tester.pump();

        expect(find.byType(ErrorScreen), findsNothing);
        expect(find.text('child rendered'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  });
}
