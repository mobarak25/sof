part of 'teacher_exam_details_bloc.dart';

class TeacherExamDetailsState extends Equatable {
  const TeacherExamDetailsState({
    this.examDtls = const ExamDetails(),
  });

  final ExamDetails examDtls;

  TeacherExamDetailsState copyWith({ExamDetails? examDtls}) {
    return TeacherExamDetailsState(examDtls: examDtls ?? this.examDtls);
  }

  @override
  List<Object> get props => [examDtls];
}

final class TeacherExamDetailsInitial extends TeacherExamDetailsState {}
