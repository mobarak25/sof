part of 'quiz_main_bloc.dart';

class QuizMainState extends Equatable {
  const QuizMainState({
    this.min = "00",
    this.sec = "00",
    this.totalTimeInSec = 0,
    this.percentage = 1,
    this.qstIndex = 0,
    this.details = const QuizDetailsForStudent(),
  });

  final String min;
  final String sec;
  final int totalTimeInSec;
  final double percentage;
  final int qstIndex;
  final QuizDetailsForStudent details;

  QuizMainState copyWith({
    String? min,
    String? sec,
    int? totalTimeInSec,
    double? percentage,
    int? qstIndex,
    QuizDetailsForStudent? details,
  }) {
    return QuizMainState(
      min: min ?? this.min,
      sec: sec ?? this.sec,
      totalTimeInSec: totalTimeInSec ?? this.totalTimeInSec,
      percentage: percentage ?? this.percentage,
      qstIndex: qstIndex ?? this.qstIndex,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [min, sec, totalTimeInSec, qstIndex, details];
}

final class QuizMainInitial extends QuizMainState {}
