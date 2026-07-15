part of 'dashboard_cubit.dart';

/// State for the dashboard courses screen.
@freezed
class DashboardState with _$DashboardState {
  /// Initial state.
  const factory DashboardState.initial() = DashboardInitial;

  /// Loading state when courses are being fetched.
  const factory DashboardState.loading() = DashboardLoading;

  /// Loaded state containing the list of available courses.
  const factory DashboardState.loaded({
    required List<CourseEntity> courses,
  }) = DashboardLoaded;

  /// Error state holding the failure message.
  const factory DashboardState.error({
    required String message,
  }) = DashboardError;
}