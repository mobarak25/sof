part of 'student_home_bloc.dart';

sealed class StudentHomeEvent extends Equatable {
  const StudentHomeEvent();

  @override
  List<Object> get props => [];
}

class GetVersion extends StudentHomeEvent {}

class GetUserProfile extends StudentHomeEvent {}

class GetNextClass extends StudentHomeEvent {}

class GetTodayActivity extends StudentHomeEvent {}

class GetSubjectList extends StudentHomeEvent {}

class GetDashboardNotice extends StudentHomeEvent {}

class GetDashboardDueTask extends StudentHomeEvent {}

class GetDashboardHomework extends StudentHomeEvent {}

class PressToDelEdit extends StudentHomeEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteAssignment extends StudentHomeEvent {
  const DeleteAssignment({required this.assignmentId});
  final int assignmentId;
}

class GetDashboardExam extends StudentHomeEvent {}

class RefreshScreen extends StudentHomeEvent {}
