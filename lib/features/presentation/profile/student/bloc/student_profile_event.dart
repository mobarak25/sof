part of 'student_profile_bloc.dart';

sealed class StudentProfileEvent extends Equatable {
  const StudentProfileEvent();

  @override
  List<Object> get props => [];
}

class GetStudentProfile extends StudentProfileEvent {}

class GetProfileAttendance extends StudentProfileEvent {}
