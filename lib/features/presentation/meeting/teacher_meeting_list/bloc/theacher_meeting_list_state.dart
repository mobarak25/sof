part of 'theacher_meeting_list_bloc.dart';

class TheacherMeetingListState extends Equatable {
  const TheacherMeetingListState({
    this.page = 1,
    this.loading = false,
    this.isFirst = true,
    this.isTeacher = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.activeTab = '0',
    this.searchText = '',
    this.meetingList = const MeetingList(),
  });

  final int page;
  final bool loading;
  final bool isFirst;
  final bool isTeacher;
  final bool isEndList;
  final bool incrementLoader;
  final String activeTab;
  final String searchText;
  final MeetingList meetingList;

  TheacherMeetingListState copyWith({
    int? page,
    bool? loading,
    bool? isFirst,
    bool? isTeacher,
    bool? isEndList,
    bool? incrementLoader,
    String? activeTab,
    String? searchText,
    MeetingList? meetingList,
  }) {
    return TheacherMeetingListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isFirst: isFirst ?? this.isFirst,
      isTeacher: isTeacher ?? this.isTeacher,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      activeTab: activeTab ?? this.activeTab,
      searchText: searchText ?? this.searchText,
      meetingList: meetingList ?? this.meetingList,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isFirst,
        isTeacher,
        isEndList,
        incrementLoader,
        activeTab,
        searchText,
        meetingList,
      ];
}

final class TheacherMeetingListInitial extends TheacherMeetingListState {}
