import '../failure/app_failure.dart';

/// Generic result type for representing success or failure outcomes
///
/// Positional record: (data, error)
/// - First element: data of type T (null on failure)
/// - Second element: error of type AppFailure (null on success)
///
/// Usage:
/// ```
/// final (data, error) = await repository.fetchData();
/// if (data != null) { /* use data */ }
/// if (error != null) { /* handle error */ }
/// ```
typedef Result<T> = (T?, AppFailure?);
