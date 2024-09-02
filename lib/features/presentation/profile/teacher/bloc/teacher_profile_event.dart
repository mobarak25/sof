part of 'teacher_profile_bloc.dart';

sealed class TeacherProfileEvent extends Equatable {
  const TeacherProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfile extends TeacherProfileEvent {}
