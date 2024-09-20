part of 'classwork_list_bloc.dart';

sealed class ClassworkListEvent extends Equatable {
  const ClassworkListEvent();

  @override
  List<Object> get props => [];
}

class IsTeacher extends ClassworkListEvent {}

class DataForTab extends ClassworkListEvent {
  const DataForTab({required this.tabIndex, required this.filterBloc});
  final String tabIndex;
  final FilterSidebarBloc filterBloc;
}

class ChangeSearch extends ClassworkListEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class GetSearchedClasswork extends ClassworkListEvent {
  const GetSearchedClasswork({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class SelectStartDate extends ClassworkListEvent {
  const SelectStartDate({
    required this.startDate,
    required this.startController,
  });
  final DateTime startDate;
  final TextEditingController startController;
}

class PressToDelEdit extends ClassworkListEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteClasswork extends ClassworkListEvent {
  const DeleteClasswork({required this.classworkId});
  final int classworkId;
}

class PressFilter extends ClassworkListEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PageIncrement extends ClassworkListEvent {
  const PageIncrement({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}
