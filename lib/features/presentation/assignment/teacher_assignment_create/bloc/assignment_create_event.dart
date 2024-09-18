part of 'assignment_create_bloc.dart';

sealed class AssignmentCreateEvent extends Equatable {
  const AssignmentCreateEvent();

  @override
  List<Object> get props => [];
}

class AssignmentIdForEdit extends AssignmentCreateEvent {
  const AssignmentIdForEdit({required this.assignmentId});
  final int assignmentId;
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
  final List<CheckUncheckStudents> students;
  final int index;
}

class PressToCreate extends AssignmentCreateEvent {
  const PressToCreate({
    required this.content,
    required this.titleFocusnode,
    required this.markFocusnode,
    required this.isDraft,
  });

  final bool isDraft;
  final String content;
  final FocusNode titleFocusnode;
  final FocusNode markFocusnode;
}

class PressToCancel extends AssignmentCreateEvent {}

class AddData extends AssignmentCreateEvent {
  const AddData({
    required this.title,
    required this.isSubmittable,
    required this.isAssessment,
    required this.mark,
    required this.startDate,
    required this.endDate,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
  });
  final String title;
  final bool isSubmittable, isAssessment;
  final int mark;
  final String startDate;
  final String endDate;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
}

class GetAssignmentAssignStudents extends AssignmentCreateEvent {
  const GetAssignmentAssignStudents({
    required this.assignmentId,
    required this.subjectId,
    required this.batchIdList,
  });
  final int assignmentId;
  final int subjectId;
  final List<int> batchIdList;
}
