part of 'theacher_review_quiz_bloc.dart';

class TheacherReviewQuizState extends Equatable {
  const TheacherReviewQuizState({
    this.totalMarks = 0,
    this.details = const QuizDetailsForStudent(),
    this.studentInfo = const QuizStudentItem(),
    this.markController = const [],
    this.marks = const [],
  });

  final num totalMarks;
  final QuizDetailsForStudent details;
  final QuizStudentItem studentInfo;
  final List<MCQOptions> markController;
  final List<Mark> marks;

  TheacherReviewQuizState copyWith({
    num? totalMarks,
    QuizDetailsForStudent? details,
    QuizStudentItem? studentInfo,
    List<MCQOptions>? markController,
    List<Mark>? marks,
  }) {
    return TheacherReviewQuizState(
      totalMarks: totalMarks ?? this.totalMarks,
      details: details ?? this.details,
      studentInfo: studentInfo ?? this.studentInfo,
      markController: markController ?? this.markController,
      marks: marks ?? this.marks,
    );
  }

  @override
  List<Object> get props => [
        totalMarks,
        details,
        studentInfo,
        markController,
        marks,
      ];
}

final class TheacherReviewQuizInitial extends TheacherReviewQuizState {}
