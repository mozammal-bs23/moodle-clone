part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, loaded, error }

enum TimelineSortType { dates, courses }

enum TimelineFilterType {
  all('All'),
  overdue('Overdue'),
  next7Days('Next 7 days'),
  next30Days('Next 30 days'),
  next3Months('Next 3 months'),
  next6Months('Next 6 months');

  const TimelineFilterType(this.label);
  final String label;
}

class DashboardState extends Equatable {
  const DashboardState({
    this.selectedTabIndex = 0,
    this.status = DashboardStatus.initial,
    this.courses = const [],
    this.message = '',
    this.timelineSortType = TimelineSortType.dates,
    this.timelineFilterType = TimelineFilterType.next30Days,
  });

  final int selectedTabIndex;
  final DashboardStatus status;
  final List<CourseEntity> courses;
  final String message;
  final TimelineSortType timelineSortType;
  final TimelineFilterType timelineFilterType;

  @override
  List<Object?> get props => [
        selectedTabIndex,
        status,
        courses,
        message,
        timelineSortType,
        timelineFilterType,
      ];

  DashboardState copyWith({
    int? selectedTabIndex,
    DashboardStatus? status,
    List<CourseEntity>? courses,
    String? message,
    TimelineSortType? timelineSortType,
    TimelineFilterType? timelineFilterType,
  }) {
    return DashboardState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      status: status ?? this.status,
      courses: courses ?? this.courses,
      message: message ?? this.message,
      timelineSortType: timelineSortType ?? this.timelineSortType,
      timelineFilterType: timelineFilterType ?? this.timelineFilterType,
    );
  }
}
