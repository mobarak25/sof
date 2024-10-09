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

class PressToDelEdit extends StudentLeaveListEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteLeave extends StudentLeaveListEvent {
  const DeleteLeave({required this.id});
  final int id;
}

class UpdateStatus extends StudentLeaveListEvent {
  const UpdateStatus({required this.id, required this.type});
  final int id;
  final String type;
}

class ConfirmUpdateStatus extends StudentLeaveListEvent {
  const ConfirmUpdateStatus(
      {required this.id, required this.type, required this.reason});
  final int id;
  final String type, reason;
}
