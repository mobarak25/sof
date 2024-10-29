part of 'take_attendance_bloc.dart';

class TakeAttendanceState extends Equatable {
  const TakeAttendanceState({
    this.isDetails = false,
    this.classInfo = '',
    this.subjectId = -1,
    this.batchId = -1,
    this.presentCount = 0,
    this.absentCount = 0,
    this.lateCount = 0,
    this.leaveCount = 0,
    this.students = const StudentsForAttendance(),
    this.tempStudents = const [],
  });

  final bool isDetails;
  final String classInfo;
  final int subjectId;
  final int batchId;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int leaveCount;
  final StudentsForAttendance students;
  final List<StudentInfo> tempStudents;

  TakeAttendanceState copyWith({
    bool? isDetails,
    String? classInfo,
    int? subjectId,
    int? batchId,
    int? presentCount,
    int? absentCount,
    int? lateCount,
    int? leaveCount,
    StudentsForAttendance? students,
    List<StudentInfo>? tempStudents,
  }) {
    return TakeAttendanceState(
      isDetails: isDetails ?? this.isDetails,
      classInfo: classInfo ?? this.classInfo,
      subjectId: subjectId ?? this.subjectId,
      batchId: batchId ?? this.batchId,
      presentCount: presentCount ?? this.presentCount,
      absentCount: absentCount ?? this.absentCount,
      lateCount: lateCount ?? this.lateCount,
      leaveCount: leaveCount ?? this.leaveCount,
      students: students ?? this.students,
      tempStudents: tempStudents ?? this.tempStudents,
    );
  }

  @override
  List<Object> get props => [
        isDetails,
        classInfo,
        subjectId,
        batchId,
        presentCount,
        absentCount,
        lateCount,
        leaveCount,
        students,
        tempStudents,
      ];
}

final class TakeAttendanceInitial extends TakeAttendanceState {}
