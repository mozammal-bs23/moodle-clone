# Error Boundary Implementation

Comprehensive error handling for the Flutter app using error boundaries, error screens, and error handlers.

## Files Created

### `lib/core/error_boundary/`

**error_boundary.dart** — Widget wrapping the app to catch uncaught errors
- Catches FlutterError exceptions
- Displays ErrorScreen on error
- Provides error callback for logging/analytics
- Resets on retry

**error_screen.dart** — UI for displaying unhandled errors
- Shows error message and stack trace (expandable)
- Retry button to reset error state
- Go Home button for navigation
- Styled with red color scheme for emphasis

**error_handler.dart** — Utility for displaying domain-level errors
- `showErrorDialog()` — modal dialog with error message
- `showErrorSnackbar()` — bottom snackbar for errors
- `getErrorMessage()` — extract user-friendly message from AppFailure

**error_boundary_export.dart** — Barrel export for easy imports

## Usage

### 1. App-Level Error Boundary (Already Done)

In `main.dart`:
```dart
return ErrorBoundary(
  onError: (error, stackTrace) {
    debugPrint('Uncaught error: $error\n$stackTrace');
    // Send to analytics/logging service
  },
  child: ScreenUtilInit(...),
);
```

### 2. Handle Domain Errors in Cubits

In cubit:
```dart
final (data, error) = await usecase();
if (error != null) {
  // Show error UI
  ErrorHandler.showErrorSnackbar(context, error);
  emit(MyError(message: error.message));
}
```

### 3. Handle Errors in Pages

In page:
```dart
BlocListener<MyCubit, MyState>(
  listener: (context, state) {
    if (state is MyError) {
      ErrorHandler.showErrorDialog(context, failure);
    }
  },
  child: ...,
)
```

## Error Types

App uses custom failure types from `flutter_boilerplate_core`:
- `NetworkFailure` — HTTP/connection errors
- `CacheFailure` — Local storage errors
- `ValidationFailure` — Input validation
- `UnknownFailure` — Unexpected errors
- `ServerFailure` — Server-side errors

## Flow

1. **Uncaught Error** → ErrorBoundary catches → ErrorScreen displays
2. **Expected Error** → Cubit emits error state → Page shows dialog/snackbar
3. **Retry** → User taps retry → Reset error state → Re-fetch data

## Testing

Error boundary catches:
- Null reference exceptions
- Type errors
- Async errors
- Widget build errors

Test by:
```dart
// In a test/widget
throw Exception('Test error');
// Should see ErrorScreen
```

## Best Practices

✅ Always emit error state in cubits
✅ Show user-friendly messages via ErrorHandler
✅ Log errors for debugging
✅ Provide retry mechanism
✅ Don't show stack traces to users (dev only)

❌ Don't hide errors silently
❌ Don't show raw exception messages
❌ Don't mix error handling patterns
