part of 'question_paper_list_bloc.dart';

sealed class QuestionPaperListEvent extends Equatable {
  const QuestionPaperListEvent();

  @override
  List<Object> get props => [];
}

class GetQstPaper extends QuestionPaperListEvent {}

class ChangeSearch extends QuestionPaperListEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class PressFilter extends QuestionPaperListEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PressToDelEdit extends QuestionPaperListEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteQuestion extends QuestionPaperListEvent {
  const DeleteQuestion({required this.qId});
  final int qId;
}

class PageIncrement extends QuestionPaperListEvent {}
