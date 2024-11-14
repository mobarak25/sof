part of 'quiz_main_bloc.dart';

sealed class QuizMainEvent extends Equatable {
  const QuizMainEvent();

  @override
  List<Object> get props => [];
}

class StartQuiz extends QuizMainEvent {}
