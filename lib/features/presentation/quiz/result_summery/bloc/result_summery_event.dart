part of 'result_summery_bloc.dart';

sealed class ResultSummeryEvent extends Equatable {
  const ResultSummeryEvent();

  @override
  List<Object> get props => [];
}

class GetQuizIdForSummery extends ResultSummeryEvent {
  const GetQuizIdForSummery({required this.quizId});
  final int quizId;
}
