import 'package:equatable/equatable.dart';

/// Base state class for all BLoC states
/// All states in the app should extend this class
abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object?> get props => [];
}

/// Initial state marker interface
/// States that represent the initial state should implement this
abstract class InitialState extends BaseState {}

/// Loading state marker interface
/// States that represent loading should implement this
abstract class LoadingState extends BaseState {}

/// Error state marker interface
/// States that represent an error should implement this
abstract class ErrorState extends BaseState {
  /// Error message
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

/// Success state marker interface
/// States that represent success should implement this
abstract class SuccessState extends BaseState {}
