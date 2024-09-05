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
    this.setClass = false,
    this.setSubject = false,
    this.setSection = false,
    this.selectedVersionId = -1,
    this.selectedClassId = -1,
    this.selectedSubjectId = -1,
    this.selectSectionId = -1,
    this.assignmentList = const TeacherAssignment(),
    this.versionList = const [DropdownItem(name: 'Select', value: -1)],
    this.classList = const [DropdownItem(name: 'Select', value: -1)],
    this.subjectList = const [DropdownItem(name: 'Select', value: -1)],
    this.sectionList = const [DropdownItem(name: 'Select', value: -1)],
    this.bacthAsSection = const GetBacthAsSections(),
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final String activeTab;
  final String searchText;
  final String startDate;
  final String endDate;
  final bool setClass;
  final bool setSubject;
  final bool setSection;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectSectionId;
  final TeacherAssignment assignmentList;
  final List<DropdownItem> versionList;
  final List<DropdownItem> classList;
  final List<DropdownItem> subjectList;
  final List<DropdownItem> sectionList;
  final GetBacthAsSections bacthAsSection;

  TeacherAssignmentListState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    String? activeTab,
    String? searchText,
    String? startDate,
    String? endDate,
    bool? setClass,
    bool? setSubject,
    bool? setSection,
    dynamic selectedVersionId,
    dynamic selectedClassId,
    dynamic selectedSubjectId,
    dynamic selectSectionId,
    TeacherAssignment? assignmentList,
    List<DropdownItem>? versionList,
    List<DropdownItem>? classList,
    List<DropdownItem>? subjectList,
    List<DropdownItem>? sectionList,
    GetBacthAsSections? bacthAsSection,
  }) {
    return TeacherAssignmentListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      activeTab: activeTab ?? this.activeTab,
      searchText: searchText ?? this.searchText,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      setClass: setClass ?? false,
      setSubject: setSubject ?? false,
      setSection: setSection ?? false,
      selectedVersionId: selectedVersionId ?? this.selectedVersionId,
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      selectSectionId: selectSectionId ?? this.selectSectionId,
      assignmentList: assignmentList ?? this.assignmentList,
      versionList: versionList ?? this.versionList,
      classList: classList ?? this.classList,
      subjectList: subjectList ?? this.subjectList,
      sectionList: sectionList ?? this.sectionList,
      bacthAsSection: bacthAsSection ?? this.bacthAsSection,
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
        setClass,
        setSubject,
        setSection,
        selectedVersionId,
        selectedClassId,
        selectedSubjectId,
        versionList,
        classList,
        subjectList,
        sectionList,
        bacthAsSection,
      ];
}

final class TeacherAssignmentListInitial extends TeacherAssignmentListState {}
