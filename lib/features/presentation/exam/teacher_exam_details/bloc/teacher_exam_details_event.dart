part of 'teacher_exam_details_bloc.dart';

sealed class TeacherExamDetailsEvent extends Equatable {
  const TeacherExamDetailsEvent();

  @override
  List<Object> get props => [];
}

class ExamIdForDtls extends TeacherExamDetailsEvent {
  const ExamIdForDtls({required this.examId});
  final int examId;
}
