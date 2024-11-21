part of 'teacher_quiz_details_bloc.dart';

class TeacherQuizDetailsState extends Equatable {
  const TeacherQuizDetailsState({
    this.quizDtls = const QuizDetailsForTeacher(),
  });

  final QuizDetailsForTeacher quizDtls;

  TeacherQuizDetailsState copyWith({QuizDetailsForTeacher? quizDtls}) {
    return TeacherQuizDetailsState(quizDtls: quizDtls ?? this.quizDtls);
  }

  @override
  List<Object> get props => [quizDtls];
}

final class TeacherQuizDetailsInitial extends TeacherQuizDetailsState {}
