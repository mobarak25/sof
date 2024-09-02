part of 'student_submission_details_bloc.dart';

class StudentSubmissionDetailsState extends Equatable {
  const StudentSubmissionDetailsState({
    this.details = const StudentAssignmentDetails(),
  });

  final StudentAssignmentDetails details;

  StudentSubmissionDetailsState copyWith({StudentAssignmentDetails? details}) {
    return StudentSubmissionDetailsState(
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [details];
}

final class StudentSubmissionDetailsInitial
    extends StudentSubmissionDetailsState {}
