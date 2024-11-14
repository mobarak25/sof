part of 'quiz_list_screen_bloc.dart';

sealed class QuizListScreenEvent extends Equatable {
  const QuizListScreenEvent();

  @override
  List<Object> get props => [];
}

class GetQuizList extends QuizListScreenEvent {}

class ChangeSearch extends QuizListScreenEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class PressFilter extends QuizListScreenEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PressToDelEdit extends QuizListScreenEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteQuestion extends QuizListScreenEvent {
  const DeleteQuestion({required this.qId});
  final int qId;
}

class PageIncrement extends QuizListScreenEvent {}
