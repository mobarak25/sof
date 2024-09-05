part of 'teacher_view_submission_bloc.dart';

class TeacherViewSubmissionState extends Equatable {
  const TeacherViewSubmissionState({
    this.details = const AssignmentDetails(),
    this.submittedList = const TeacherSummitedAssinentView(),
    this.controllers = const [],
  });

  final AssignmentDetails details;
  final TeacherSummitedAssinentView submittedList;
  final List<TextEditingController> controllers;

  TeacherViewSubmissionState copyWith({
    AssignmentDetails? details,
    TeacherSummitedAssinentView? submittedList,
    List<TextEditingController>? controllers,
  }) {
    return TeacherViewSubmissionState(
      details: details ?? this.details,
      submittedList: submittedList ?? this.submittedList,
      controllers: controllers ?? this.controllers,
    );
  }

  @override
  List<Object> get props => [details, submittedList, controllers];
}

final class TeacherViewSubmissionInitial extends TeacherViewSubmissionState {}
