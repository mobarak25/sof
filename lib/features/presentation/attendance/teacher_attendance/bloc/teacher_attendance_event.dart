part of 'teacher_attendance_bloc.dart';

sealed class TeacherAttendanceEvent extends Equatable {
  const TeacherAttendanceEvent();

  @override
  List<Object> get props => [];
}

class GetBactch extends TeacherAttendanceEvent {}

class GetIdList extends TeacherAttendanceEvent {
  const GetIdList(
      {required this.subjectId,
      required this.batchId,
      required this.className});
  final int subjectId;
  final int batchId;
  final String className;
}

class GetDate extends TeacherAttendanceEvent {
  const GetDate({required this.date});
  final DateTime date;
}

class DataForTab extends TeacherAttendanceEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}
