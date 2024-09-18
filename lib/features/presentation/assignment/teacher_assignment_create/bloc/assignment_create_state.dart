part of 'assignment_create_bloc.dart';

class AssignmentCreateState extends Equatable {
  const AssignmentCreateState({
    this.assignmentId = -1,
    this.loading = false,
    this.forms = Forms.initial,
    this.batchLoading = false,
    this.title = '',
    this.fileList = const [],
    this.isSubmitable = true,
    this.isAssessment = true,
    this.mark = '',
    this.startDate = '',
    this.endDate = '',
    //dependable
    this.bacthAsSection = const GetBacthAsSections(),
    this.setClass = false,
    this.setSubject = false,
    this.setSection = false,
    this.selectedVersionId = -1,
    this.selectedClassId = -1,
    this.selectedSubjectId = -1,
    this.selectSectionId = -1,
    this.versionList = const [DropdownItem(name: 'Select', value: -1)],
    this.classList = const [DropdownItem(name: 'Select', value: -1)],
    this.subjectList = const [DropdownItem(name: 'Select', value: -1)],
    this.sectionList = const [],
    this.assignToBatchId = const [],
    this.selectedBatchName = const [],
    this.selecteClassName = '',
    this.batchWiseStudent = const [],
    //End dependable
    // this.tempBatchWiseStudent = const [], //may be no need
    this.listOfCheckUncheckStudent = const [],
    this.assingmentDtls = const AssignmentDetails(),
    this.isFirstTime = true,
    this.assignmentAssignStudentForEdit = const [],
  });

  final int assignmentId;
  final bool loading, batchLoading;
  final Forms forms;
  final String title;
  final List<File> fileList;
  final bool isSubmitable;
  final bool isAssessment;
  final String mark;
  final String startDate;
  final String endDate;

  //dependable dropdown
  final GetBacthAsSections bacthAsSection;
  final bool setClass;
  final bool setSubject;
  final bool setSection;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectSectionId;
  final List<DropdownItem> versionList;
  final List<DropdownItem> classList;
  final List<DropdownItem> subjectList;
  final List<DropDownValueModel> sectionList;
  //final List<DropdownItem> sectionList;
  //End dependable dropdown

  final List<int> assignToBatchId;
  final List<String> selectedBatchName;
  final String selecteClassName;
  final List<BatchWiseStudent> batchWiseStudent;
  // final List<BatchWiseStudent> tempBatchWiseStudent;
  final List<List<CheckUncheckStudents>> listOfCheckUncheckStudent;
  final AssignmentDetails assingmentDtls;
  final bool isFirstTime;
  final List<AssignmentAssignStudent> assignmentAssignStudentForEdit;

  AssignmentCreateState copyWith({
    int? assignmentId,
    bool? loading,
    Forms? forms,
    bool? batchLoading,
    List<File>? fileList,
    String? title,
    bool? isSubmitable,
    bool? isAssessment,
    String? mark,
    String? startDate,
    String? endDate,
    //
    GetBacthAsSections? bacthAsSection,
    bool? setClass,
    bool? setSubject,
    bool? setSection,
    dynamic selectedVersionId,
    dynamic selectedClassId,
    dynamic selectedSubjectId,
    dynamic selectSectionId,
    List<DropdownItem>? versionList,
    List<DropdownItem>? classList,
    List<DropdownItem>? subjectList,
    List<DropDownValueModel>? sectionList,
    //
    List<int>? assignToBatchId,
    List<String>? selectedBatchName,
    String? selecteClassName,
    List<BatchWiseStudent>? batchWiseStudent,
    List<BatchWiseStudent>? tempBatchWiseStudent,
    List<List<CheckUncheckStudents>>? listOfCheckUncheckStudent,
    AssignmentDetails? assingmentDtls,
    bool? isFirstTime,
    List<AssignmentAssignStudent>? assignmentAssignStudentForEdit,
  }) {
    return AssignmentCreateState(
      assignmentId: assignmentId ?? this.assignmentId,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      batchLoading: batchLoading ?? this.batchLoading,
      title: title ?? this.title,
      fileList: fileList ?? this.fileList,
      isSubmitable: isSubmitable ?? this.isSubmitable,
      isAssessment: isAssessment ?? this.isAssessment,
      mark: mark ?? this.mark,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      //dropdown
      bacthAsSection: bacthAsSection ?? this.bacthAsSection,
      setClass: setClass ?? false,
      setSubject: setSubject ?? false,
      setSection: setSection ?? false,
      selectedVersionId: selectedVersionId ?? this.selectedVersionId,
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      selectSectionId: selectSectionId ?? this.selectSectionId,
      versionList: versionList ?? this.versionList,
      classList: classList ?? this.classList,
      subjectList: subjectList ?? this.subjectList,
      sectionList: sectionList ?? this.sectionList,
      //End dropdown
      assignToBatchId: assignToBatchId ?? this.assignToBatchId,
      selectedBatchName: selectedBatchName ?? this.selectedBatchName,
      selecteClassName: selecteClassName ?? this.selecteClassName,
      batchWiseStudent: batchWiseStudent ?? this.batchWiseStudent,
      // tempBatchWiseStudent: tempBatchWiseStudent ?? this.tempBatchWiseStudent,
      listOfCheckUncheckStudent:
          listOfCheckUncheckStudent ?? this.listOfCheckUncheckStudent,
      assingmentDtls: assingmentDtls ?? this.assingmentDtls,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      assignmentAssignStudentForEdit:
          assignmentAssignStudentForEdit ?? this.assignmentAssignStudentForEdit,
    );
  }

  @override
  List<Object> get props => [
        assignmentId,
        loading,
        forms,
        batchLoading,
        title,
        fileList,
        isSubmitable,
        isAssessment,
        mark,
        startDate,
        endDate,
        //dropdown
        bacthAsSection,
        setClass,
        setSubject,
        setSection,
        selectedVersionId,
        selectedClassId,
        selectedSubjectId,
        selectSectionId,
        versionList,
        classList,
        subjectList,
        sectionList,
        //end dropdown
        assignToBatchId,
        selectedBatchName,
        selecteClassName,
        batchWiseStudent,
        // tempBatchWiseStudent,
        listOfCheckUncheckStudent,
        assingmentDtls,
        isFirstTime,
        assignmentAssignStudentForEdit,
      ];
}

final class AssignmentCreateInitial extends AssignmentCreateState {}
