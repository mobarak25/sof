part of 'quiz_main_bloc.dart';

class QuizMainState extends Equatable {
  const QuizMainState({
    this.min = 0,
    this.sec = 0,
    this.totalTimeInSec = 300,
  });

  final int min;
  final int sec;
  final int totalTimeInSec;

  QuizMainState copyWith({int? min, int? sec, int? totalTimeInSec}) {
    return QuizMainState(
      min: min ?? this.min,
      sec: sec ?? this.sec,
      totalTimeInSec: totalTimeInSec ?? this.totalTimeInSec,
    );
  }

  @override
  List<Object> get props => [min, sec, totalTimeInSec];
}

final class QuizMainInitial extends QuizMainState {}
