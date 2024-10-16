part of 'teacher_own_leave_bloc.dart';

sealed class TeacherOwnLeaveEvent extends Equatable {
  const TeacherOwnLeaveEvent();

  @override
  List<Object> get props => [];
}

class DataForTab extends TeacherOwnLeaveEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}

class ChangeSearch extends TeacherOwnLeaveEvent {
  const ChangeSearch({required this.searchText});
  final String searchText;
}

class GetSearchedLeave extends TeacherOwnLeaveEvent {}

class SelectStartDate extends TeacherOwnLeaveEvent {
  const SelectStartDate({
    required this.startDate,
    required this.startController,
  });
  final DateTime startDate;
  final TextEditingController startController;
}

class SelectEndDate extends TeacherOwnLeaveEvent {
  const SelectEndDate({
    required this.endDate,
    required this.endController,
  });
  final DateTime endDate;
  final TextEditingController endController;
}

class PressFilter extends TeacherOwnLeaveEvent {}

class PageIncrement extends TeacherOwnLeaveEvent {}

class PressToDelEdit extends TeacherOwnLeaveEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteLeave extends TeacherOwnLeaveEvent {
  const DeleteLeave({required this.id});
  final int id;
}

class UpdateStatus extends TeacherOwnLeaveEvent {
  const UpdateStatus({required this.id, required this.type});
  final int id;
  final String type;
}

class ConfirmUpdateStatus extends TeacherOwnLeaveEvent {
  const ConfirmUpdateStatus(
      {required this.id, required this.type, required this.reason});
  final int id;
  final String type, reason;
}
