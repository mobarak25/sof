part of 'student_assignment_list_bloc.dart';

sealed class StudentAssignmentListEvent extends Equatable {
  const StudentAssignmentListEvent();

  @override
  List<Object> get props => [];
}

class DataForTab extends StudentAssignmentListEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}

class ChangeSearch extends StudentAssignmentListEvent {
  const ChangeSearch({required this.searchText});
  final String searchText;
}

class GetSearchedAssignment extends StudentAssignmentListEvent {}

class ChangeStartDate extends StudentAssignmentListEvent {
  const ChangeStartDate({required this.startDate});
  final String startDate;
}

class SelectStartDate extends StudentAssignmentListEvent {
  const SelectStartDate({
    required this.startDate,
    required this.startController,
  });
  final DateTime startDate;
  final TextEditingController startController;
}

class SelectEndDate extends StudentAssignmentListEvent {
  const SelectEndDate({
    required this.endDate,
    required this.endDateController,
  });
  final DateTime endDate;
  final TextEditingController endDateController;
}

class GetSubjectList extends StudentAssignmentListEvent {}

class SelectSubjectId extends StudentAssignmentListEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class PressFilter extends StudentAssignmentListEvent {}
