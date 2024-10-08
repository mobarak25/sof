part of 'student_leave_list_bloc.dart';

class StudentLeaveListState extends Equatable {
  const StudentLeaveListState({
    this.page = 1,
    this.loading = false,
    this.isFirst = true,
    this.isEndList = false,
    this.incrementLoader = false,
    this.subjectId = -1,
    this.activeTab = '0',
    this.searchText = '',
    this.startDate = '',
    this.endDate = '',
    this.userType = '',
    this.leaveList = const StudentLeaveList(),
  });

  final int page;
  final bool loading;
  final bool isFirst;
  final bool isEndList;
  final int subjectId;
  final bool incrementLoader;
  final String activeTab;
  final String searchText;
  final String startDate;
  final String endDate;
  final String userType;
  final StudentLeaveList leaveList;

  StudentLeaveListState copyWith({
    int? page,
    bool? loading,
    bool? isFirst,
    bool? isEndList,
    bool? incrementLoader,
    int? subjectId,
    String? activeTab,
    String? searchText,
    String? startDate,
    String? endDate,
    String? userType,
    StudentLeaveList? leaveList,
  }) {
    return StudentLeaveListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isFirst: isFirst ?? this.isFirst,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      subjectId: subjectId ?? this.subjectId,
      activeTab: activeTab ?? this.activeTab,
      searchText: searchText ?? this.searchText,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      userType: userType ?? this.userType,
      leaveList: leaveList ?? this.leaveList,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isFirst,
        isEndList,
        incrementLoader,
        subjectId,
        activeTab,
        searchText,
        startDate,
        endDate,
        userType,
        leaveList,
      ];
}

final class StudentLeaveListInitial extends StudentLeaveListState {}
