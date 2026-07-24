part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, loaded, error }

class DashboardState extends Equatable {
  const DashboardState({
    this.selectedTabIndex = 0,
    this.status = DashboardStatus.initial,
    this.courses = const [],
    this.message = '',
  });

  final int selectedTabIndex;
  final DashboardStatus status;
  final List<CourseEntity> courses;
  final String message;

  @override
  List<Object?> get props => [selectedTabIndex, status, courses, message];

  DashboardState copyWith({
    int? selectedTabIndex,
    DashboardStatus? status,
    List<CourseEntity>? courses,
    String? message,
  }) {
    return DashboardState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      status: status ?? this.status,
      courses: courses ?? this.courses,
      message: message ?? this.message,
    );
  }
}
