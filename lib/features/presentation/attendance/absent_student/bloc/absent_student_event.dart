part of 'absent_student_bloc.dart';

sealed class AbsentStudentEvent extends Equatable {
  const AbsentStudentEvent();

  @override
  List<Object> get props => [];
}

class GetStudents extends AbsentStudentEvent {
  const GetStudents({
    required this.subjectId,
    required this.batchId,
    required this.classInfo,
  });
  final int subjectId;
  final int batchId;
  final String classInfo;
}
