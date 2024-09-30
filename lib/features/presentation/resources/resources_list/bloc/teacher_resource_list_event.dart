part of 'teacher_resource_list_bloc.dart';

sealed class TeacherResourceListEvent extends Equatable {
  const TeacherResourceListEvent();

  @override
  List<Object> get props => [];
}

class IsTeacher extends TeacherResourceListEvent {}

class DataForTab extends TeacherResourceListEvent {
  const DataForTab({required this.tabIndex, required this.filterBloc});
  final String tabIndex;
  final FilterSidebarBloc filterBloc;
}

class ChangeSearch extends TeacherResourceListEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class GetSearchedResources extends TeacherResourceListEvent {
  const GetSearchedResources({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PressToDelEdit extends TeacherResourceListEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteResource extends TeacherResourceListEvent {
  const DeleteResource({required this.resourceId});
  final int resourceId;
}

class PressFilter extends TeacherResourceListEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PageIncrement extends TeacherResourceListEvent {
  const PageIncrement({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}
