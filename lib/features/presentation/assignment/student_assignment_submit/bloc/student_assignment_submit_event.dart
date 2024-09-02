part of 'student_assignment_submit_bloc.dart';

sealed class StudentAssignmentSubmitEvent extends Equatable {
  const StudentAssignmentSubmitEvent();

  @override
  List<Object> get props => [];
}

class SubmitAssignment extends StudentAssignmentSubmitEvent {
  const SubmitAssignment({required this.id});
  final int id;
}

class GetFile extends StudentAssignmentSubmitEvent {}

class RemoveFile extends StudentAssignmentSubmitEvent {
  const RemoveFile({required this.index});
  final int index;
}

class ChangeContent extends StudentAssignmentSubmitEvent {
  const ChangeContent({required this.content});
  final String content;
}

class PressToSumit extends StudentAssignmentSubmitEvent {
  const PressToSumit({required this.work});
  final String work;
}

class PressToDraft extends StudentAssignmentSubmitEvent {
  const PressToDraft({required this.work});
  final String work;
}

class PressToCancel extends StudentAssignmentSubmitEvent {}

class PressToConfirmCancel extends StudentAssignmentSubmitEvent {}
