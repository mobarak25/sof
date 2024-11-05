part of 'question_paper_details_bloc.dart';

class QuestionPaperDetailsState extends Equatable {
  const QuestionPaperDetailsState({
    this.details = const QuestionPaperDtls(),
  });

  final QuestionPaperDtls details;

  QuestionPaperDetailsState copyWith({QuestionPaperDtls? details}) {
    return QuestionPaperDetailsState(details: details ?? this.details);
  }

  @override
  List<Object> get props => [details];
}

final class QuestionPaperDetailsInitial extends QuestionPaperDetailsState {}
