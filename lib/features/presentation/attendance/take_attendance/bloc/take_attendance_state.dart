part of 'take_attendance_bloc.dart';

class TakeAttendanceState extends Equatable {
  const TakeAttendanceState({
    this.classInfo = '',
    this.subjectId = -1,
    this.batchId = -1,
    this.tempIndex = -1,
    this.students = const StudentsForAttendance(),
  });

  final String classInfo;
  final int subjectId;
  final int batchId;
  final int tempIndex;
  final StudentsForAttendance students;

  TakeAttendanceState copyWith({
    String? classInfo,
    int? subjectId,
    int? batchId,
    int? tempIndex,
    StudentsForAttendance? students,
  }) {
    return TakeAttendanceState(
      classInfo: classInfo ?? this.classInfo,
      subjectId: subjectId ?? this.subjectId,
      batchId: batchId ?? this.batchId,
      tempIndex: tempIndex ?? this.tempIndex,
      students: students ?? this.students,
    );
  }

  @override
  List<Object> get props =>
      [classInfo, subjectId, batchId, tempIndex, students];
}

final class TakeAttendanceInitial extends TakeAttendanceState {}
