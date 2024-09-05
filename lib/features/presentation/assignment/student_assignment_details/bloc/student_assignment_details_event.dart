part of 'student_assignment_details_bloc.dart';

sealed class StudentAssignmentDetailsEvent extends Equatable {
  const StudentAssignmentDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetDetails extends StudentAssignmentDetailsEvent {
  const GetDetails({required this.assingmentId});
  final int assingmentId;
}

class CheckTeacher extends StudentAssignmentDetailsEvent {}
