part of 'student_attendance_bloc.dart';

sealed class StudentAttendanceEvent extends Equatable {
  const StudentAttendanceEvent();

  @override
  List<Object> get props => [];
}

class PressFilter extends StudentAttendanceEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class GetStudentOverView extends StudentAttendanceEvent {
  const GetStudentOverView({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class GetCalanderOverView extends StudentAttendanceEvent {
  const GetCalanderOverView({required this.date});
  final DateTime date;
}

class TodayAttendance extends StudentAttendanceEvent {}
