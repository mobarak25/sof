part of 'class_work_create_bloc.dart';

sealed class ClassWorkCreateEvent extends Equatable {
  const ClassWorkCreateEvent();

  @override
  List<Object> get props => [];
}

class ClassworkIdForEdit extends ClassWorkCreateEvent {
  const ClassworkIdForEdit({required this.classworkId});
  final int classworkId;
}

class ChangeTitle extends ClassWorkCreateEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class PublishDate extends ClassWorkCreateEvent {
  const PublishDate({required this.publishedAt});
  final String publishedAt;
}

class GetFile extends ClassWorkCreateEvent {}

class RemoveFile extends ClassWorkCreateEvent {
  const RemoveFile({required this.index});
  final int index;
}

//dropdown
class GetVersionList extends ClassWorkCreateEvent {}

class SelectVersionId extends ClassWorkCreateEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends ClassWorkCreateEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends ClassWorkCreateEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectSectionId extends ClassWorkCreateEvent {
  const SelectSectionId({required this.id});
  final dynamic id;
}

class SelectSectionList extends ClassWorkCreateEvent {
  const SelectSectionList({required this.sectionList});
  final List<dynamic> sectionList;
}
//end dropdown

class BackWithUnselected extends ClassWorkCreateEvent {
  const BackWithUnselected({required this.students, required this.index});
  final List<CheckUncheckStudents> students;
  final int index;
}

class PressToCreate extends ClassWorkCreateEvent {
  const PressToCreate({
    required this.content,
    required this.titleFocusnode,
    required this.isDraft,
  });

  final bool isDraft;
  final String content;
  final FocusNode titleFocusnode;
}

class PressToCancel extends ClassWorkCreateEvent {}

class AddData extends ClassWorkCreateEvent {
  const AddData({
    required this.title,
    required this.publishAt,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
  });
  final String title;
  final String publishAt;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
}
