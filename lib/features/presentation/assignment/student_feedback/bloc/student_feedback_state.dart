part of 'student_feedback_bloc.dart';

class StudentFeedbackState extends Equatable {
  const StudentFeedbackState({
    this.feedback = const AssignmentFeedback(),
  });

  final AssignmentFeedback feedback;

  StudentFeedbackState copyWith({AssignmentFeedback? feedback}) {
    return StudentFeedbackState(feedback: feedback ?? this.feedback);
  }

  @override
  List<Object> get props => [feedback];
}

final class StudentFeedbackInitial extends StudentFeedbackState {}
