part of 'student_assignment_details_bloc.dart';

class StudentAssignmentDetailsState extends Equatable {
  const StudentAssignmentDetailsState({
    this.details = const AssignmentDetails(),
  });

  final AssignmentDetails details;

  StudentAssignmentDetailsState copyWith({AssignmentDetails? details}) {
    return StudentAssignmentDetailsState(details: details ?? this.details);
  }

  @override
  List<Object> get props => [details];
}

final class StudentAssignmentDetailsInitial
    extends StudentAssignmentDetailsState {}
