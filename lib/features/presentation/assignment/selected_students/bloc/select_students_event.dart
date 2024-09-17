part of 'select_students_bloc.dart';

sealed class SelectStudentsEvent extends Equatable {
  const SelectStudentsEvent();

  @override
  List<Object> get props => [];
}

class GetInitialStudents extends SelectStudentsEvent {
  const GetInitialStudents({required this.students});
  final List<CheckUncheckStudents> students;
}

class ToggleCheckbox extends SelectStudentsEvent {
  const ToggleCheckbox({required this.value, required this.id});
  final bool value;
  final int id;
}

class ToggleSelectAll extends SelectStudentsEvent {
  const ToggleSelectAll({required this.value});
  final bool value;
}

class ChageSearch extends SelectStudentsEvent {
  const ChageSearch({required this.search});
  final String search;
}
