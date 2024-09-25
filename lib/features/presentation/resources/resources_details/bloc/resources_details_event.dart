part of 'resources_details_bloc.dart';

sealed class ResourcesDetailsEvent extends Equatable {
  const ResourcesDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetResourceDetails extends ResourcesDetailsEvent {
  const GetResourceDetails({required this.resourcesId});
  final int resourcesId;
}

class IsTeacher extends ResourcesDetailsEvent {}

class PressToDelEdit extends ResourcesDetailsEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteResource extends ResourcesDetailsEvent {
  const DeleteResource({required this.resourceId});
  final int resourceId;
}
