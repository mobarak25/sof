part of 'leave_details_bloc.dart';

sealed class LeaveDetailsEvent extends Equatable {
  const LeaveDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetLeaveDetails extends LeaveDetailsEvent {
  const GetLeaveDetails({required this.leaveId});
  final int leaveId;
}
