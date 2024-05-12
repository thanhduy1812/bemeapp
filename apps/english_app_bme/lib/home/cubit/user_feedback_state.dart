part of 'user_feedback_cubit.dart';

@immutable
sealed class UserFeedbackState {}

final class UserFeedbackInitial extends UserFeedbackState {
  final List<UserFeedback> userFeedbacks;

  UserFeedbackInitial({required this.userFeedbacks});
}

final class UserFeedbackLoading extends UserFeedbackState {}
