part of 'student_feedback_bloc.dart';

class StudentFeedbackState extends Equatable {
  const StudentFeedbackState({
    this.page = 1,
    this.isEndList = false,
    this.submissionId = -1,
    this.incrementLoader = false,
    this.feedback = const AssignmentFeedback(),
  });

  final int page;
  final int submissionId;
  final bool isEndList;
  final bool incrementLoader;
  final AssignmentFeedback feedback;

  StudentFeedbackState copyWith(
      {AssignmentFeedback? feedback,
      int? page,
      bool? isEndList,
      int? submissionId,
      bool? incrementLoader}) {
    return StudentFeedbackState(
      page: page ?? this.page,
      isEndList: isEndList ?? this.isEndList,
      submissionId: submissionId ?? this.submissionId,
      feedback: feedback ?? this.feedback,
      incrementLoader: incrementLoader ?? this.incrementLoader,
    );
  }

  @override
  List<Object> get props =>
      [page, feedback, incrementLoader, submissionId, isEndList];
}

final class StudentFeedbackInitial extends StudentFeedbackState {}
