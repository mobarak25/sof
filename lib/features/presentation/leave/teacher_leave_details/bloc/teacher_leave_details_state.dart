part of 'teacher_leave_details_bloc.dart';

class TeacherLeaveDetailsState extends Equatable {
  const TeacherLeaveDetailsState({
    this.details = const TeacherLeaveDetails(),
  });

  final TeacherLeaveDetails details;

  TeacherLeaveDetailsState copyWith({
    TeacherLeaveDetails? details,
  }) {
    return TeacherLeaveDetailsState(
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [details];
}

final class TeacherLeaveDetailsInitial extends TeacherLeaveDetailsState {}
