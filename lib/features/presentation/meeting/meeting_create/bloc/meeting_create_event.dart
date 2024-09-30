part of 'meeting_create_bloc.dart';

sealed class MeetingCreateEvent extends Equatable {
  const MeetingCreateEvent();

  @override
  List<Object> get props => [];
}

class MeetingIdForEdit extends MeetingCreateEvent {
  const MeetingIdForEdit({required this.meetingId});
  final int meetingId;
}

class ChangeTitle extends MeetingCreateEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class StartDate extends MeetingCreateEvent {
  const StartDate({required this.startDate});
  final String startDate;
}

//dropdown
class GetVersionList extends MeetingCreateEvent {}

class SelectVersionId extends MeetingCreateEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends MeetingCreateEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSectionList extends MeetingCreateEvent {
  const SelectSectionList({required this.sectionList});
  final List<dynamic> sectionList;
}
//end dropdown

class BackWithUnselected extends MeetingCreateEvent {
  const BackWithUnselected({required this.students, required this.index});
  final List<CheckUncheckStudents> students;
  final int index;
}

class PressToCreate extends MeetingCreateEvent {
  const PressToCreate({
    required this.content,
    required this.titleFocusnode,
    required this.isDraft,
  });

  final bool isDraft;
  final String content;
  final FocusNode titleFocusnode;
}

class PressToCancel extends MeetingCreateEvent {}

class AddData extends MeetingCreateEvent {
  const AddData({
    required this.title,
    required this.startDate,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
  });
  final String title;
  final String startDate;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
}

class GetAssignmentAssignStudents extends MeetingCreateEvent {
  const GetAssignmentAssignStudents({
    required this.assignmentId,
    required this.subjectId,
    required this.batchIdList,
  });
  final int assignmentId;
  final int subjectId;
  final List<int> batchIdList;
}
