part of 'teacher_quiz_details_bloc.dart';

sealed class TeacherQuizDetailsEvent extends Equatable {
  const TeacherQuizDetailsEvent();

  @override
  List<Object> get props => [];
}

class TeacherGetQuizIdForDtls extends TeacherQuizDetailsEvent {
  const TeacherGetQuizIdForDtls({required this.quizId});
  final int quizId;
}
