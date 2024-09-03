part of 'teacher_assignment_list_bloc.dart';

class TeacherAssignmentListState extends Equatable {
  const TeacherAssignmentListState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.activeTab = '0',
    this.searchText = '',
    this.startDate = '',
    this.endDate = '',
    this.subjectId = '',
    this.selectedVersionId = -1,
    this.assignmentList = const TeacherAssignment(),
    this.versionList = const [DropdownItem(name: 'Select Subject', value: -1)],
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final String activeTab;
  final String searchText;
  final String startDate;
  final String endDate;
  final dynamic selectedVersionId;
  final String subjectId;
  final TeacherAssignment assignmentList;
  final List<DropdownItem> versionList;

  TeacherAssignmentListState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    String? activeTab,
    String? searchText,
    String? startDate,
    String? endDate,
    String? subjectId,
    dynamic selectedVersionId,
    TeacherAssignment? assignmentList,
    List<DropdownItem>? versionList,
  }) {
    return TeacherAssignmentListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      activeTab: activeTab ?? this.activeTab,
      searchText: searchText ?? this.searchText,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      subjectId: subjectId ?? this.subjectId,
      selectedVersionId: selectedVersionId ?? this.selectedVersionId,
      assignmentList: assignmentList ?? this.assignmentList,
      versionList: versionList ?? this.versionList,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isEndList,
        activeTab,
        searchText,
        assignmentList,
        startDate,
        endDate,
        subjectId,
        selectedVersionId,
        versionList,
      ];
}

final class TeacherAssignmentListInitial extends TeacherAssignmentListState {}
