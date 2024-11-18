part of 'quiz_finish_bloc.dart';

sealed class QuizFinishEvent extends Equatable {
  const QuizFinishEvent();

  @override
  List<Object> get props => [];
}

class GetIdForQuizDtls extends QuizFinishEvent {
  const GetIdForQuizDtls({required this.quizId});
  final int quizId;
}
