part of 'student_feedback_bloc.dart';

sealed class StudentFeedbackEvent extends Equatable {
  const StudentFeedbackEvent();

  @override
  List<Object> get props => [];
}

class GetFeedback extends StudentFeedbackEvent {
  const GetFeedback({required this.id});
  final int id;
}
