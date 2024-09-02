part of 'student_profile_bloc.dart';

class StudentProfileState extends Equatable {
  const StudentProfileState({
    this.profile = const StudentProfileResponse(),
    this.attendance = const ProfileAttendanceResponse(),
  });

  final StudentProfileResponse profile;
  final ProfileAttendanceResponse attendance;

  StudentProfileState copyWith({
    StudentProfileResponse? profile,
    ProfileAttendanceResponse? attendance,
  }) {
    return StudentProfileState(
      profile: profile ?? this.profile,
      attendance: attendance ?? this.attendance,
    );
  }

  @override
  List<Object> get props => [profile, attendance];
}

final class StudentProfileInitial extends StudentProfileState {}
