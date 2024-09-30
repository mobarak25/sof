part of 'lesson_plan_create_bloc.dart';

sealed class LessonPlanCreateEvent extends Equatable {
  const LessonPlanCreateEvent();

  @override
  List<Object> get props => [];
}

class PlanIdForEdit extends LessonPlanCreateEvent {
  const PlanIdForEdit({required this.planId});
  final int planId;
}

class ChangeTitle extends LessonPlanCreateEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class OpenBottomSheet extends LessonPlanCreateEvent {}

class GetFile extends LessonPlanCreateEvent {}

class RemoveFile extends LessonPlanCreateEvent {
  const RemoveFile({required this.index});
  final int index;
}

//dropdown
class GetVersionList extends LessonPlanCreateEvent {}

class SelectVersionId extends LessonPlanCreateEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends LessonPlanCreateEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends LessonPlanCreateEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectSectionId extends LessonPlanCreateEvent {
  const SelectSectionId({required this.id});
  final dynamic id;
}

//end dropdown

class GetSelectedResourceIds extends LessonPlanCreateEvent {
  const GetSelectedResourceIds({required this.resourceIds});
  final List<int> resourceIds;
}

class PressToCreate extends LessonPlanCreateEvent {
  const PressToCreate({
    required this.content,
    required this.objectiveContent,
    required this.titleFocusnode,
    required this.isDraft,
  });

  final bool isDraft;
  final String content;
  final String objectiveContent;
  final FocusNode titleFocusnode;
}

class PressToCancel extends LessonPlanCreateEvent {}

class AddData extends LessonPlanCreateEvent {
  const AddData({
    required this.title,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.selectedSectionId,
  });
  final String title;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectedSectionId;
}
