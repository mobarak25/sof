part of 'student_quiz_details_bloc.dart';

sealed class StudentQuizDetailsEvent extends Equatable {
  const StudentQuizDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetQuizIdForDtls extends StudentQuizDetailsEvent {
  const GetQuizIdForDtls({required this.quizId});
  final int quizId;
}
