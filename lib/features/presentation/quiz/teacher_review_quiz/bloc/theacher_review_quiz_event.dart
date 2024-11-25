part of 'theacher_review_quiz_bloc.dart';

sealed class TheacherReviewQuizEvent extends Equatable {
  const TheacherReviewQuizEvent();

  @override
  List<Object> get props => [];
}

class GetDtlsForReview extends TheacherReviewQuizEvent {
  const GetDtlsForReview({
    required this.id,
    required this.studentInfo,
  });
  final int id;
  final QuizStudentItem studentInfo;
}

class ChangeMark extends TheacherReviewQuizEvent {
  const ChangeMark({required this.mark, required this.questionId});
  final String mark;
  final int questionId;
}

class PressToSave extends TheacherReviewQuizEvent {}

class PressToReset extends TheacherReviewQuizEvent {}
