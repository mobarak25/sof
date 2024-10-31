part of 'syllabus_create_bloc.dart';

sealed class SyllabusCreateEvent extends Equatable {
  const SyllabusCreateEvent();

  @override
  List<Object> get props => [];
}

class SyllabusIdForEdit extends SyllabusCreateEvent {
  const SyllabusIdForEdit({required this.syllabusId});
  final int syllabusId;
}

class ChangeTitle extends SyllabusCreateEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class ChangeMarks extends SyllabusCreateEvent {
  const ChangeMarks({required this.marks});
  final String marks;
}

class PublishDate extends SyllabusCreateEvent {
  const PublishDate({required this.publishedAt});
  final String publishedAt;
}

class SelectSyllabusType extends SyllabusCreateEvent {
  const SelectSyllabusType({required this.type});
  final dynamic type;
}

class GetFile extends SyllabusCreateEvent {}

class RemoveFile extends SyllabusCreateEvent {
  const RemoveFile({required this.index});
  final int index;
}

//===========
class GetVersionList extends SyllabusCreateEvent {}

class SelectVersionId extends SyllabusCreateEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends SyllabusCreateEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends SyllabusCreateEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectSectionId extends SyllabusCreateEvent {
  const SelectSectionId({required this.id});
  final dynamic id;
}

//==================

class PressToCreate extends SyllabusCreateEvent {
  const PressToCreate({
    required this.content,
    required this.titleFocusnode,
    required this.isDraft,
  });

  final bool isDraft;
  final String content;
  final FocusNode titleFocusnode;
}

class PressToCancel extends SyllabusCreateEvent {}

class AddData extends SyllabusCreateEvent {
  const AddData({
    required this.title,
    required this.content,
    required this.date,
    required this.marks,
    required this.syllabusType,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.selectedSectionId,
  });

  final String title;
  final String content;
  final String date;
  final String marks;
  final dynamic syllabusType;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectedSectionId;
}
