part of 'student_classwork_list_bloc.dart';

sealed class StudentClassworkListEvent extends Equatable {
  const StudentClassworkListEvent();

  @override
  List<Object> get props => [];
}

class DataForTab extends StudentClassworkListEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}

class ChangeSearch extends StudentClassworkListEvent {
  const ChangeSearch({required this.searchText});
  final String searchText;
}

class GetSearchedClasswork extends StudentClassworkListEvent {}

class SelectStartDate extends StudentClassworkListEvent {
  const SelectStartDate({
    required this.startDate,
    required this.startController,
  });
  final DateTime startDate;
  final TextEditingController startController;
}

class PressFilter extends StudentClassworkListEvent {}

class PageIncrement extends StudentClassworkListEvent {}
