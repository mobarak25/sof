part of 'student_assignment_details_bloc.dart';

class StudentAssignmentDetailsState extends Equatable {
  const StudentAssignmentDetailsState({
    this.details = const AssignmentDetails(),
    this.isTeacher = false,
  });

  final bool isTeacher;
  final AssignmentDetails details;

  StudentAssignmentDetailsState copyWith({
    AssignmentDetails? details,
    bool? isTeacher,
  }) {
    return StudentAssignmentDetailsState(
      isTeacher: isTeacher ?? this.isTeacher,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [isTeacher, details];
}

final class StudentAssignmentDetailsInitial
    extends StudentAssignmentDetailsState {}
