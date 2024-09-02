part of 'student_submission_details_bloc.dart';

sealed class StudentSubmissionDetailsEvent extends Equatable {
  const StudentSubmissionDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetSubmissionDetails extends StudentSubmissionDetailsEvent {
  const GetSubmissionDetails({required this.id});
  final int id;
}
