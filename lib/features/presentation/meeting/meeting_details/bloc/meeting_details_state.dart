part of 'meeting_details_bloc.dart';

class MeetingDetailsState extends Equatable {
  const MeetingDetailsState({
    this.isTeacher = false,
    this.details = const MeetingDetails(),
    this.assignStudents = const [],
  });

  final bool isTeacher;
  final MeetingDetails details;
  final List<BatchWiseStudentItem> assignStudents;

  MeetingDetailsState copyWith({
    bool? isTeacher,
    MeetingDetails? details,
    List<BatchWiseStudentItem>? assignStudents,
  }) {
    return MeetingDetailsState(
      isTeacher: isTeacher ?? this.isTeacher,
      details: details ?? this.details,
      assignStudents: assignStudents ?? this.assignStudents,
    );
  }

  @override
  List<Object> get props => [isTeacher, details, assignStudents];
}

final class MeetingDetailsInitial extends MeetingDetailsState {}
