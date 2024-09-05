part of 'teacher_assignment_list_bloc.dart';

sealed class TeacherAssignmentListEvent extends Equatable {
  const TeacherAssignmentListEvent();

  @override
  List<Object> get props => [];
}

class DataForTab extends TeacherAssignmentListEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}

class ChangeSearch extends TeacherAssignmentListEvent {
  const ChangeSearch({required this.searchText});
  final String searchText;
}

class GetSearchedAssignment extends TeacherAssignmentListEvent {}

class ChangeStartDate extends TeacherAssignmentListEvent {
  const ChangeStartDate({required this.startDate});
  final String startDate;
}

class SelectStartDate extends TeacherAssignmentListEvent {
  const SelectStartDate({
    required this.startDate,
    required this.startController,
  });
  final DateTime startDate;
  final TextEditingController startController;
}

class SelectEndDate extends TeacherAssignmentListEvent {
  const SelectEndDate({
    required this.endDate,
    required this.endDateController,
  });
  final DateTime endDate;
  final TextEditingController endDateController;
}

class GetVersionList extends TeacherAssignmentListEvent {}

class SelectVersionId extends TeacherAssignmentListEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends TeacherAssignmentListEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class PressFilter extends TeacherAssignmentListEvent {}
