part of 'teacher_leave_details_bloc.dart';

sealed class TeacherLeaveDetailsEvent extends Equatable {
  const TeacherLeaveDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetTeacherLeaveDetails extends TeacherLeaveDetailsEvent {
  const GetTeacherLeaveDetails({required this.leaveId});
  final int leaveId;
}
