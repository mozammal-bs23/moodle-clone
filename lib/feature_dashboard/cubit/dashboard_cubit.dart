import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

/// Entity representing a course item on the dashboard.
class CourseEntity {
  /// Creates a new [CourseEntity] instance.
  CourseEntity({
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.progress,
  });

  /// The title of the course.
  final String title;

  /// The category or department of the course.
  final String category;

  /// The banner image URL for the course.
  final String imageUrl;

  /// The progress completion percentage.
  final double progress;
}

/// Cubit for managing the dashboard screen state.
@injectable
class DashboardCubit extends Cubit<DashboardState> {
  /// Creates a new [DashboardCubit] instance.
  DashboardCubit() : super(const DashboardState.initial());

  /// Fetches the list of enrolled courses for the dashboard.
  Future<void> fetchDashboardCourses() async {
    emit(const DashboardState.loading());
    try {
      // Simulate network delay
      await Future<void>.delayed(const Duration(milliseconds: 800));

      final mockCourses = [
        CourseEntity(
          title: 'A1/A2 English with H5P',
          category: 'English as a Foreign Language',
          imageUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=500',
          progress: 0.15,
        ),
        CourseEntity(
          title: 'Mindful Course Creation',
          category: 'Faculty of Education',
          imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=500',
          progress: 0.5,
        ),
        CourseEntity(
          title: 'Mobile App Development',
          category: 'Computer Science',
          imageUrl: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=500',
          progress: 0.8,
        ),
      ];

      emit(DashboardState.loaded(courses: mockCourses));
    } catch (e) {
      emit(DashboardState.error(message: e.toString()));
    }
  }
}
