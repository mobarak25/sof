part of 'take_attendance_bloc.dart';

sealed class TakeAttendanceEvent extends Equatable {
  const TakeAttendanceEvent();

  @override
  List<Object> get props => [];
}

class GetParams extends TakeAttendanceEvent {
  const GetParams(
      {required this.subjectId,
      required this.batchId,
      required this.classInfo});
  final int subjectId;
  final int batchId;
  final String classInfo;
}

class StudentForAttendance extends TakeAttendanceEvent {}

class ChangeStatus extends TakeAttendanceEvent {
  const ChangeStatus({required this.index});
  final int index;
}
