import 'package:flutter_bloc/flutter_bloc.dart';

/// Global observer for all BLoC/Cubit state changes
/// 
/// Helps track state transitions and errors across the application.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // Can add logging or analytics here
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Can add logging or analytics here
  }

  @override
  void onChangeWithOrigin(BlocBase bloc, Change change, StackTrace stackTrace) {
    super.onChangeWithOrigin(bloc, change, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // Can add logging or analytics here
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // Can add error logging or crash reporting here
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    // Can add cleanup logic here
  }
}
