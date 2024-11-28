part of 'theacher_mark_entry_bloc.dart';

class TheacherMarkEntryState extends Equatable {
  const TheacherMarkEntryState({
    this.examId = -1,
    this.loading = false,
    this.students = const ExamMarkEntry(),
    this.tempExamMark = const [],
  });

  final int examId;
  final bool loading;
  final ExamMarkEntry students;
  final List<ExamMark> tempExamMark;

  TheacherMarkEntryState copyWith({
    int? examId,
    bool? loading,
    ExamMarkEntry? students,
    List<ExamMark>? tempExamMark,
  }) {
    return TheacherMarkEntryState(
      loading: loading ?? this.loading,
      examId: examId ?? this.examId,
      students: students ?? this.students,
      tempExamMark: tempExamMark ?? this.tempExamMark,
    );
  }

  @override
  List<Object> get props => [loading, examId, students, tempExamMark];
}

final class TheacherMarkEntryInitial extends TheacherMarkEntryState {}
