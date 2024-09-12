part of 'student_assignment_list_bloc.dart';

class StudentAssignmentListState extends Equatable {
  const StudentAssignmentListState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.activeTab = '',
    this.searchText = '',
    this.startDate = '',
    this.endDate = '',
    this.subjectId = '',
    this.selectedSubId = -1,
    this.assignmentList = const AssignmentResponse(),
    this.subjectList = const [DropdownItem(name: 'Select Subject', value: -1)],
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final String activeTab;
  final String searchText;
  final String startDate;
  final String endDate;
  final dynamic selectedSubId;
  final String subjectId;
  final AssignmentResponse assignmentList;
  final List<DropdownItem> subjectList;

  StudentAssignmentListState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    String? activeTab,
    String? searchText,
    String? startDate,
    String? endDate,
    String? subjectId,
    dynamic selectedSubId,
    AssignmentResponse? assignmentList,
    List<DropdownItem>? subjectList,
  }) {
    return StudentAssignmentListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      activeTab: activeTab ?? this.activeTab,
      searchText: searchText ?? this.searchText,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      subjectId: subjectId ?? this.subjectId,
      selectedSubId: selectedSubId ?? this.selectedSubId,
      assignmentList: assignmentList ?? this.assignmentList,
      subjectList: subjectList ?? this.subjectList,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isEndList,
        incrementLoader,
        activeTab,
        searchText,
        assignmentList,
        startDate,
        endDate,
        subjectId,
        selectedSubId,
        subjectList,
      ];
}

final class StudentAssignmentListInitial extends StudentAssignmentListState {}
