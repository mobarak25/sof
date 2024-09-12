part of 'assignment_create_bloc.dart';

sealed class AssignmentCreateEvent extends Equatable {
  const AssignmentCreateEvent();

  @override
  List<Object> get props => [];
}

class ChangeTitle extends AssignmentCreateEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class GetFile extends AssignmentCreateEvent {}

class RemoveFile extends AssignmentCreateEvent {
  const RemoveFile({required this.index});
  final int index;
}

class Submitable extends AssignmentCreateEvent {
  const Submitable({required this.isSubmitable});
  final bool isSubmitable;
}

class Assessment extends AssignmentCreateEvent {
  const Assessment({required this.isAssessment});
  final bool isAssessment;
}

class ChangeMark extends AssignmentCreateEvent {
  const ChangeMark({required this.mark});
  final String mark;
}

class StartDate extends AssignmentCreateEvent {
  const StartDate({required this.startDate});
  final String startDate;
}

class EndDate extends AssignmentCreateEvent {
  const EndDate({required this.endDate});
  final String endDate;
}

//dropdown
class GetVersionList extends AssignmentCreateEvent {}

class SelectVersionId extends AssignmentCreateEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends AssignmentCreateEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends AssignmentCreateEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectSectionId extends AssignmentCreateEvent {
  const SelectSectionId({required this.id});
  final dynamic id;
}

class SelectSectionList extends AssignmentCreateEvent {
  const SelectSectionList({required this.sectionList});
  final List<dynamic> sectionList;
}
//end dropdown

class BackWithUnselected extends AssignmentCreateEvent {
  const BackWithUnselected({required this.students, required this.index});
  final List<bool> students;
  final int index;
}

class PressToCreate extends AssignmentCreateEvent {
  const PressToCreate({
    required this.content,
    required this.titleFocusnode,
    required this.markFocusnode,
  });
  final String content;
  final FocusNode titleFocusnode;
  final FocusNode markFocusnode;
}
