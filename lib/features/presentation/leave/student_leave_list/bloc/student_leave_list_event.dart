part of 'student_leave_list_bloc.dart';

sealed class StudentLeaveListEvent extends Equatable {
  const StudentLeaveListEvent();

  @override
  List<Object> get props => [];
}

class DataForTab extends StudentLeaveListEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}

class ChangeSearch extends StudentLeaveListEvent {
  const ChangeSearch({required this.searchText});
  final String searchText;
}

class GetSearchedLeave extends StudentLeaveListEvent {}

class SelectStartDate extends StudentLeaveListEvent {
  const SelectStartDate({
    required this.startDate,
    required this.startController,
  });
  final DateTime startDate;
  final TextEditingController startController;
}

class SelectEndDate extends StudentLeaveListEvent {
  const SelectEndDate({
    required this.endDate,
    required this.endController,
  });
  final DateTime endDate;
  final TextEditingController endController;
}

class PressFilter extends StudentLeaveListEvent {}

class PageIncrement extends StudentLeaveListEvent {}
