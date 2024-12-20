part of 'quiz_main_bloc.dart';

class QuizMainState extends Equatable {
  const QuizMainState({
    this.min = "00",
    this.sec = "00",
    this.loading = false,
    this.totalTimeInSec = 0,
    this.percentage = 1,
    this.qstIndex = 0,
    this.quizAns = const [],
    this.trackTime = const TrackTime(),
    this.details = const QuizDetailsForStudent(),
  });

  final String min;
  final String sec;
  final bool loading;
  final int totalTimeInSec;
  final double percentage;
  final int qstIndex;
  final TrackTime trackTime;
  final List<QuizAns> quizAns;
  final QuizDetailsForStudent details;

  QuizMainState copyWith({
    String? min,
    String? sec,
    bool? loading,
    int? totalTimeInSec,
    double? percentage,
    int? qstIndex,
    TrackTime? trackTime,
    List<QuizAns>? quizAns,
    QuizDetailsForStudent? details,
  }) {
    return QuizMainState(
      min: min ?? this.min,
      sec: sec ?? this.sec,
      loading: loading ?? this.loading,
      totalTimeInSec: totalTimeInSec ?? this.totalTimeInSec,
      percentage: percentage ?? this.percentage,
      qstIndex: qstIndex ?? this.qstIndex,
      quizAns: quizAns ?? this.quizAns,
      trackTime: trackTime ?? this.trackTime,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [
        min,
        sec,
        loading,
        totalTimeInSec,
        qstIndex,
        quizAns,
        details,
        trackTime,
      ];
}

final class QuizMainInitial extends QuizMainState {}
