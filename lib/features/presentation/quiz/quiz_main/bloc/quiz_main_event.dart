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

class PressToOptions extends QuizMainEvent {
  const PressToOptions({required this.questionIndex, required this.ans});
  final int questionIndex;
  final String ans;
}

class ChangeExplanation extends QuizMainEvent {
  const ChangeExplanation({required this.explanation});
  final String explanation;
}

class PressToFinish extends QuizMainEvent {}

class GetTrackTime extends QuizMainEvent {}
