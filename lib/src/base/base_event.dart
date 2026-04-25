import 'package:equatable/equatable.dart';

/// Base event class for all BLoC events
/// All events in the app should extend this class
abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object?> get props => [];
}
