part of 'attach_resource_bloc.dart';

sealed class AttachResourceEvent extends Equatable {
  const AttachResourceEvent();

  @override
  List<Object> get props => [];
}

class GetAllResources extends AttachResourceEvent {}

class GetResourcesCheckedIds extends AttachResourceEvent {
  const GetResourcesCheckedIds({required this.idList});
  final List<int> idList;
}

class ChangeSearch extends AttachResourceEvent {
  const ChangeSearch({required this.search});
  final String search;
}

class ToggleCheckbox extends AttachResourceEvent {
  const ToggleCheckbox({required this.value, required this.id});
  final bool value;
  final int id;
}
