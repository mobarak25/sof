part of 'result_summery_bloc.dart';

class ResultSummeryState extends Equatable {
  const ResultSummeryState({
    this.details = const QuizDetailsForStudent(),
  });

  final QuizDetailsForStudent details;

  ResultSummeryState copyWith({QuizDetailsForStudent? details}) {
    return ResultSummeryState(details: details ?? this.details);
  }

  @override
  List<Object> get props => [];
}

final class ResultSummeryInitial extends ResultSummeryState {}
