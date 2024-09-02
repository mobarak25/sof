part of 'apply_leave_bloc.dart';

sealed class ApplyLeaveEvent extends Equatable {
  const ApplyLeaveEvent();

  @override
  List<Object> get props => [];
}

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

class OpenBottomSheet extends ApplyLeaveEvent {}

class PickImage extends ApplyLeaveEvent {
  const PickImage({required this.imageSource});
  final ImageSource imageSource;
}

class GetFile extends ApplyLeaveEvent {}
