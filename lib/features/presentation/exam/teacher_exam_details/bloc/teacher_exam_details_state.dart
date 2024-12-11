part of 'teacher_exam_details_bloc.dart';

class TeacherExamDetailsState extends Equatable {
  const TeacherExamDetailsState({
    this.isTeacher = false,
    this.examDtls = const ExamDetails(),
  });

  final bool isTeacher;
  final ExamDetails examDtls;

  TeacherExamDetailsState copyWith({bool? isTeacher, ExamDetails? examDtls}) {
    return TeacherExamDetailsState(
      isTeacher: isTeacher ?? this.isTeacher,
      examDtls: examDtls ?? this.examDtls,
    );
  }

  @override
  List<Object> get props => [isTeacher, examDtls];
}

final class TeacherExamDetailsInitial extends TeacherExamDetailsState {}
