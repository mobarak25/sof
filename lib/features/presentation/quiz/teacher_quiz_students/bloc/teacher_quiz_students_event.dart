part of 'teacher_quiz_students_bloc.dart';

sealed class TeacherQuizStudentsEvent extends Equatable {
  const TeacherQuizStudentsEvent();

  @override
  List<Object> get props => [];
}

class GetQuizIdForStudents extends TeacherQuizStudentsEvent {
  const GetQuizIdForStudents({required this.quizId});
  final int quizId;
}

class PageIncrement extends TeacherQuizStudentsEvent {}
