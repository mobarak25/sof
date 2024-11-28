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

class RefreshScreen extends StudentHomeEvent {}
