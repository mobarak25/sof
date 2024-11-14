part of 'student_quiz_list_bloc.dart';

sealed class StudentQuizListEvent extends Equatable {
  const StudentQuizListEvent();

  @override
  List<Object> get props => [];
}

class GetQuizList extends StudentQuizListEvent {}

class ChangeSearch extends StudentQuizListEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class PressFilter extends StudentQuizListEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PageIncrement extends StudentQuizListEvent {}
