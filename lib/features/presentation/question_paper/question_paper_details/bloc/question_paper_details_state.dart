part of 'question_paper_details_bloc.dart';

sealed class QuestionPaperDetailsState extends Equatable {
  const QuestionPaperDetailsState();
  
  @override
  List<Object> get props => [];
}

final class QuestionPaperDetailsInitial extends QuestionPaperDetailsState {}
