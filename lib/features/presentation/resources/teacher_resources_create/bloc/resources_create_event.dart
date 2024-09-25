part of 'resources_create_bloc.dart';

sealed class ResourcesCreateEvent extends Equatable {
  const ResourcesCreateEvent();

  @override
  List<Object> get props => [];
}

class ResourceIdForEdit extends ResourcesCreateEvent {
  const ResourceIdForEdit({required this.resourceId});
  final int resourceId;
}

class ChangeTitle extends ResourcesCreateEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class ChangeVideoLink extends ResourcesCreateEvent {
  const ChangeVideoLink({required this.link});
  final String link;
}

class GetFile extends ResourcesCreateEvent {
  const GetFile({required this.isThumb});
  final bool isThumb;
}

class RemoveFile extends ResourcesCreateEvent {
  const RemoveFile({required this.index, required this.isThumb});
  final int index;
  final bool isThumb;
}

//dropdown
class GetVersionList extends ResourcesCreateEvent {}

class SelectVersionId extends ResourcesCreateEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends ResourcesCreateEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends ResourcesCreateEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectChapterId extends ResourcesCreateEvent {
  const SelectChapterId({required this.id});
  final dynamic id;
}

class SelectResourceType extends ResourcesCreateEvent {
  const SelectResourceType({required this.type});
  final dynamic type;
}

//end dropdown
class GetChapter extends ResourcesCreateEvent {}

class CreateChapter extends ResourcesCreateEvent {}

class PressToCreate extends ResourcesCreateEvent {
  const PressToCreate({
    required this.content,
    required this.titleFocusnode,
    required this.isDraft,
  });

  final bool isDraft;
  final String content;
  final FocusNode titleFocusnode;
}

class PressToCancel extends ResourcesCreateEvent {}

class AddData extends ResourcesCreateEvent {
  const AddData({
    required this.title,
    required this.videoLink,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.selectedChapterId,
    required this.selectedResourceType,
  });
  final String title, videoLink;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectedChapterId;
  final dynamic selectedResourceType;
}
