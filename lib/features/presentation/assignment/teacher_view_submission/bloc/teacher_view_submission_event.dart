part of 'teacher_view_submission_bloc.dart';

sealed class TeacherViewSubmissionEvent extends Equatable {
  const TeacherViewSubmissionEvent();

  @override
  List<Object> get props => [];
}

class GetAssignmentDtls extends TeacherViewSubmissionEvent {
  const GetAssignmentDtls({required this.id});
  final int id;
}

class GetSubmissionList extends TeacherViewSubmissionEvent {
  const GetSubmissionList({required this.id});
  final int id;
}
