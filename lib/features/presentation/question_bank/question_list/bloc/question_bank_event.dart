part of 'question_bank_bloc.dart';

sealed class QuestionBankEvent extends Equatable {
  const QuestionBankEvent();

  @override
  List<Object> get props => [];
}

class GetQuestion extends QuestionBankEvent {}

class ChangeSearch extends QuestionBankEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class PressFilter extends QuestionBankEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PageIncrement extends QuestionBankEvent {}
