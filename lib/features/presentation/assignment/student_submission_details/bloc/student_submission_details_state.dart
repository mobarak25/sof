part of 'student_submission_details_bloc.dart';

class StudentSubmissionDetailsState extends Equatable {
  const StudentSubmissionDetailsState({
    this.details = const StudentAssignmentDetails(),
    this.isTeacher = false,
    this.mark = '',
  });

  final StudentAssignmentDetails details;
  final bool isTeacher;
  final String mark;

  StudentSubmissionDetailsState copyWith({
    StudentAssignmentDetails? details,
    bool? isTeacher,
    String? mark,
  }) {
    return StudentSubmissionDetailsState(
      details: details ?? this.details,
      isTeacher: isTeacher ?? this.isTeacher,
      mark: mark ?? this.mark,
    );
  }

  @override
  List<Object> get props => [details, isTeacher, mark];
}

final class StudentSubmissionDetailsInitial
    extends StudentSubmissionDetailsState {}
