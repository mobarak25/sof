part of 'quiz_main_bloc.dart';

class QuizMainState extends Equatable {
  const QuizMainState({
    this.min = "00",
    this.sec = "00",
    this.totalTimeInSec = 0,
    this.percentage = 1,
    this.qstIndex = 0,
    this.quizAns = const [],
    this.details = const QuizDetailsForStudent(),
  });

  final String min;
  final String sec;
  final int totalTimeInSec;
  final double percentage;
  final int qstIndex;
  final List<QuizAns> quizAns;
  final QuizDetailsForStudent details;

  QuizMainState copyWith({
    String? min,
    String? sec,
    int? totalTimeInSec,
    double? percentage,
    int? qstIndex,
    List<QuizAns>? quizAns,
    QuizDetailsForStudent? details,
  }) {
    return QuizMainState(
      min: min ?? this.min,
      sec: sec ?? this.sec,
      totalTimeInSec: totalTimeInSec ?? this.totalTimeInSec,
      percentage: percentage ?? this.percentage,
      qstIndex: qstIndex ?? this.qstIndex,
      quizAns: quizAns ?? this.quizAns,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [
        min,
        sec,
        totalTimeInSec,
        qstIndex,
        quizAns,
        details,
      ];
}

final class QuizMainInitial extends QuizMainState {}
