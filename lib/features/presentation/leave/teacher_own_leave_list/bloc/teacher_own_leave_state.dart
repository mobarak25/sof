part of 'teacher_own_leave_bloc.dart';

class TeacherOwnLeaveState extends Equatable {
  const TeacherOwnLeaveState({
    this.page = 1,
    this.loading = false,
    this.isTeacher = false,
    this.isFirst = true,
    this.isEndList = false,
    this.incrementLoader = false,
    this.subjectId = -1,
    this.activeTab = '0',
    this.searchText = '',
    this.startDate = '',
    this.endDate = '',
    this.userType = '',
    this.leaveList = const TeacherOwnLeaveList(),
  });

  final int page;
  final bool loading;
  final bool isTeacher;
  final bool isFirst;
  final bool isEndList;
  final int subjectId;
  final bool incrementLoader;
  final String activeTab;
  final String searchText;
  final String startDate;
  final String endDate;
  final String userType;
  final TeacherOwnLeaveList leaveList;

  TeacherOwnLeaveState copyWith({
    int? page,
    bool? loading,
    bool? isTeacher,
    bool? isFirst,
    bool? isEndList,
    bool? incrementLoader,
    int? subjectId,
    String? activeTab,
    String? searchText,
    String? startDate,
    String? endDate,
    String? userType,
    TeacherOwnLeaveList? leaveList,
  }) {
    return TeacherOwnLeaveState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isTeacher: isTeacher ?? this.isTeacher,
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
        isTeacher,
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

final class TeacherOwnLeaveInitial extends TeacherOwnLeaveState {}
