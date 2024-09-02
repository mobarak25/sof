part of 'teacher_profile_bloc.dart';

class TeacherProfileState extends Equatable {
  const TeacherProfileState({
    this.profile = const TeacherProfileResponse(),
  });

  final TeacherProfileResponse profile;

  TeacherProfileState copyWith({TeacherProfileResponse? profile}) {
    return TeacherProfileState(profile: profile ?? this.profile);
  }

  @override
  List<Object> get props => [profile];
}

final class TeacherProfileInitial extends TeacherProfileState {}
