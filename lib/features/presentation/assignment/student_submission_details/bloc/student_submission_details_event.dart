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

class CheckTeacher extends StudentSubmissionDetailsEvent {}

class OpenAcceptSheet extends StudentSubmissionDetailsEvent {}

class OpenResubmitSheet extends StudentSubmissionDetailsEvent {}

class OpenDenySheet extends StudentSubmissionDetailsEvent {}

class SubmitMark extends StudentSubmissionDetailsEvent {
  const SubmitMark({required this.mark, required this.feedback});
  final String mark;
  final String feedback;
}

class ReSubmit extends StudentSubmissionDetailsEvent {
  const ReSubmit({required this.date, required this.feedback});
  final String date;
  final String feedback;
}

class SubmitDeny extends StudentSubmissionDetailsEvent {
  const SubmitDeny({required this.feedback});
  final String feedback;
}
