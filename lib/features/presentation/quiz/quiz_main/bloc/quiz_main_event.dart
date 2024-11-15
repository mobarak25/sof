part of 'quiz_main_bloc.dart';

sealed class QuizMainEvent extends Equatable {
  const QuizMainEvent();

  @override
  List<Object> get props => [];
}

class GetQuizIdForStart extends QuizMainEvent {
  const GetQuizIdForStart({required this.quizId});
  final int quizId;
}

class StartQuiz extends QuizMainEvent {}

class StopTimer extends QuizMainEvent {}

class UpdateTime extends QuizMainEvent {
  const UpdateTime({
    required this.min,
    required this.sec,
    required this.secondCounter,
  });
  final String min, sec;
  final int secondCounter;
}

class PressToNext extends QuizMainEvent {}

class PressToPrev extends QuizMainEvent {}
