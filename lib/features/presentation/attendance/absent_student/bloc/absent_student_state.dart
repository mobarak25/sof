part of 'absent_student_bloc.dart';

class AbsentStudentState extends Equatable {
  const AbsentStudentState({
    this.students = const AbsentStudents(),
  });

  final AbsentStudents students;

  AbsentStudentState copyWith({AbsentStudents? students}) {
    return AbsentStudentState(students: students ?? this.students);
  }

  @override
  List<Object> get props => [students];
}

final class AbsentStudentInitial extends AbsentStudentState {}
