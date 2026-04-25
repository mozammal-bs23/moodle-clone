/// Generic result type for representing success or failure outcomes
///
/// This sealed class helps avoid using exceptions for control flow
/// and makes error handling explicit in the type system.
import '../failure/app_failure.dart';

sealed class Result<T> {
  const Result();

  /// Creates a successful result with [data]
  const factory Result.success(T data) = Success<T>;

  /// Creates a failure result with [failure]
  const factory Result.failure(AppFailure failure) = Failure<T>;

  /// Returns the data if successful, otherwise null
  T? get dataOrNull => switch (this) {
        Success(:final data) => data,
        Failure() => null,
      };

  /// Returns the failure if failed, otherwise null
  AppFailure? get failureOrNull => switch (this) {
        Success() => null,
        Failure(:final failure) => failure,
      };

  /// Maps the result to a new type
  Result<R> map<R>(R Function(T data) onSuccess) => switch (this) {
        Success(:final data) => Result.success(onSuccess(data)),
        Failure(:final failure) => Result.failure(failure),
      };

  /// Executes a function if successful
  Result<T> onSuccess(void Function(T data) action) {
    switch (this) {
      case Success(:final value):
        action(value);
    }
    return this;
  }

  /// Executes a function if failed
  Result<T> onFailure(void Function(AppFailure failure) action) {
    switch (this) {
      case Failure(:final value):
        action(value);
    }
    return this;
  }

  /// Returns data or a default value
  T getOrElse(T defaultValue) => switch (this) {
        Success(:final data) => data,
        Failure() => defaultValue,
      };

  /// Returns data or computes from a function
  T getOrCompute(T Function(AppFailure failure) compute) => switch (this) {
        Success(:final data) => data,
        Failure(:final failure) => compute(failure),
      };

  /// Checks if the result is successful
  bool get isSuccess => this is Success<T>;

  /// Checks if the result is a failure
  bool get isFailure => this is Failure<T>;

  /// Converts to a string representation
  @override
  String toString() => switch (this) {
        Success(:final data) => 'Result.success($data)',
        Failure(:final failure) => 'Result.failure($failure)',
      };
}

/// Represents a successful operation with data
final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);

  @override
  String toString() => 'Success($data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Success<T> && data == other.data;

  @override
  int get hashCode => data.hashCode;
}

/// Represents a failed operation with an [AppFailure]
final class Failure<T> extends Result<T> {
  final AppFailure failure;
  const Failure(this.failure);

  @override
  String toString() => 'Failure($failure)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Failure<T> && failure == other.failure;

  @override
  int get hashCode => failure.hashCode;
}
