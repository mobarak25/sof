part of 'teacher_apply_leave_bloc.dart';

sealed class TeacherApplyLeaveEvent extends Equatable {
  const TeacherApplyLeaveEvent();

  @override
  List<Object> get props => [];
}

class OwnLeaveIdForEdit extends TeacherApplyLeaveEvent {
  const OwnLeaveIdForEdit({required this.leaveId});
  final int leaveId;
}

class GetLeaveType extends TeacherApplyLeaveEvent {}

class SelectLeaveType extends TeacherApplyLeaveEvent {
  const SelectLeaveType({required this.value});
  final dynamic value;
}

class SelectStartDate extends TeacherApplyLeaveEvent {
  const SelectStartDate(
      {required this.startDate,
      required this.startController,
      required this.endController});
  final DateTime startDate;
  final TextEditingController startController;
  final TextEditingController endController;
}

class SelectEnd extends TeacherApplyLeaveEvent {
  const SelectEnd(
      {required this.endDate,
      required this.endController,
      required this.startController});
  final DateTime endDate;
  final TextEditingController endController;
  final TextEditingController startController;
}

class GetIsHalfDay extends TeacherApplyLeaveEvent {
  const GetIsHalfDay({required this.isHalfDay});
  final bool isHalfDay;
}

class GetIsEmergency extends TeacherApplyLeaveEvent {
  const GetIsEmergency({required this.isEmergency});
  final bool isEmergency;
}

class ChangeDescription extends TeacherApplyLeaveEvent {
  const ChangeDescription({required this.desc});
  final String desc;
}

class GetFile extends TeacherApplyLeaveEvent {}

class RemoveFile extends TeacherApplyLeaveEvent {
  const RemoveFile({required this.index});
  final int index;
}

class PressToApply extends TeacherApplyLeaveEvent {
  const PressToApply({
    required this.startFocusnode,
    required this.endFocusnode,
    required this.descFocusnode,
  });

  final FocusNode startFocusnode;
  final FocusNode endFocusnode;
  final FocusNode descFocusnode;
}

class AddData extends TeacherApplyLeaveEvent {
  const AddData({
    required this.startDate,
    required this.endDate,
    required this.desc,
    required this.selectedType,
    required this.isHalfDay,
    required this.isEmergency,
  });

  final String startDate;
  final String endDate;
  final String desc;
  final dynamic selectedType;
  final bool isHalfDay;
  final bool isEmergency;
}
