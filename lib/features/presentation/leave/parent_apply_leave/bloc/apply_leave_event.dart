part of 'apply_leave_bloc.dart';

sealed class ApplyLeaveEvent extends Equatable {
  const ApplyLeaveEvent();

  @override
  List<Object> get props => [];
}

class LeaveIdForEdit extends ApplyLeaveEvent {
  const LeaveIdForEdit({required this.leaveId});
  final int leaveId;
}

class GetLeaveType extends ApplyLeaveEvent {}

class ChangeTitle extends ApplyLeaveEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class SelectLeaveType extends ApplyLeaveEvent {
  const SelectLeaveType({required this.value});
  final dynamic value;
}

class SelectStartDate extends ApplyLeaveEvent {
  const SelectStartDate(
      {required this.startDate,
      required this.startController,
      required this.endController});
  final DateTime startDate;
  final TextEditingController startController;
  final TextEditingController endController;
}

class SelectEnd extends ApplyLeaveEvent {
  const SelectEnd(
      {required this.endDate,
      required this.endController,
      required this.startController});
  final DateTime endDate;
  final TextEditingController endController;
  final TextEditingController startController;
}

class GetIsHalfDay extends ApplyLeaveEvent {
  const GetIsHalfDay({required this.isHalfDay});
  final bool isHalfDay;
}

class ChangeDescription extends ApplyLeaveEvent {
  const ChangeDescription({required this.desc});
  final String desc;
}

class GetFile extends ApplyLeaveEvent {}

class RemoveFile extends ApplyLeaveEvent {
  const RemoveFile({required this.index});
  final int index;
}

class PressToApply extends ApplyLeaveEvent {
  const PressToApply({
    required this.startFocusnode,
    required this.endFocusnode,
    required this.descFocusnode,
    required this.titleFocusnode,
  });

  final FocusNode startFocusnode;
  final FocusNode endFocusnode;
  final FocusNode descFocusnode;
  final FocusNode titleFocusnode;
}

class AddData extends ApplyLeaveEvent {
  const AddData({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.desc,
    required this.selectedType,
    required this.isHalfDay,
  });
  final String title;
  final String startDate;
  final String endDate;
  final String desc;
  final dynamic selectedType;
  final bool isHalfDay;
}
