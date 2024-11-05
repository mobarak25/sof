part of 'question_paper_details_bloc.dart';

sealed class QuestionPaperDetailsEvent extends Equatable {
  const QuestionPaperDetailsEvent();

  @override
  List<Object> get props => [];
}

class QuestionPaperDetails extends QuestionPaperDetailsEvent {
  const QuestionPaperDetails({required this.paperId});
  final int paperId;
}
