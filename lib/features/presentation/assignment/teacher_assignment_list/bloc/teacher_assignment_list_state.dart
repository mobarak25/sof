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
    this.setClass = false,
    this.selectedVersionId = -1,
    this.selectedClassId = -1,
    this.assignmentList = const TeacherAssignment(),
    this.versionList = const [DropdownItem(name: 'Select Subject', value: -1)],
    this.classList = const [],
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final String activeTab;
  final String searchText;
  final String startDate;
  final String endDate;
  final bool setClass;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final String subjectId;
  final TeacherAssignment assignmentList;
  final List<DropdownItem> versionList;
  final List<DropdownItem> classList;

  TeacherAssignmentListState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    String? activeTab,
    String? searchText,
    String? startDate,
    String? endDate,
    String? subjectId,
    bool? setClass,
    dynamic selectedVersionId,
    dynamic selectedClassId,
    TeacherAssignment? assignmentList,
    List<DropdownItem>? versionList,
    List<DropdownItem>? classList,
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
      setClass: setClass ?? false,
      selectedVersionId: selectedVersionId ?? this.selectedVersionId,
      selectedClassId: selectedClassId ?? this.selectedClassId,
      assignmentList: assignmentList ?? this.assignmentList,
      versionList: versionList ?? this.versionList,
      classList: classList ?? this.classList,
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
        setClass,
        selectedVersionId,
        selectedClassId,
        versionList,
        classList,
      ];
}

final class TeacherAssignmentListInitial extends TeacherAssignmentListState {}
