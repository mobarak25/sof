part of 'theacher_meeting_list_bloc.dart';

sealed class TheacherMeetingListEvent extends Equatable {
  const TheacherMeetingListEvent();

  @override
  List<Object> get props => [];
}

class DataForTab extends TheacherMeetingListEvent {
  const DataForTab({required this.tabIndex, required this.filterBloc});
  final String tabIndex;
  final FilterSidebarBloc filterBloc;
}

class ChangeSearch extends TheacherMeetingListEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class GetSearchedMeeting extends TheacherMeetingListEvent {
  const GetSearchedMeeting({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PressToDelEdit extends TheacherMeetingListEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteMeeting extends TheacherMeetingListEvent {
  const DeleteMeeting({required this.resourceId});
  final int resourceId;
}

class PressFilter extends TheacherMeetingListEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PageIncrement extends TheacherMeetingListEvent {
  const PageIncrement({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}
