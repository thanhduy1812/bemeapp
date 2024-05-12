part of 'bme_course_cubit.dart';

@immutable
sealed class BmeCourseState {}

final class BmeCourseInitial extends BmeCourseState {
  final List<BmeOriginCourse> courses;

  BmeCourseInitial({required this.courses});
}

final class BmeCourseLoading extends BmeCourseState {}

final class BmeCourseLError extends BmeCourseState {}
