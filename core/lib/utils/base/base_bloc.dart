import 'package:bloc/bloc.dart';
import 'package:flutter_boilerplate_core/utils/base/base_event.dart';
import 'package:flutter_boilerplate_core/utils/base/base_state.dart';

/// Base BLoC class that provides common functionality
/// All BLoCs in the app should extend this class
///
/// Type parameters:
/// - E: Event type (extends [BaseEvent])
/// - S: State type (extends [BaseState])
abstract class BaseBloc<E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  /// Creates a [BaseBloc] with an initial state
  BaseBloc(super.initialState);
}
