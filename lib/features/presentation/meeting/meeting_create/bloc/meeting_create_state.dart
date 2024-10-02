part of 'meeting_create_bloc.dart';

class MeetingCreateState extends Equatable {
  const MeetingCreateState({
    this.meetingId = -1,
    this.loading = false,
    this.forms = Forms.initial,
    this.batchLoading = false,
    this.title = '',
    this.date = '',
    this.startTime = '',
    this.endTime = '',
    this.link = '',
    this.agenda = const [],
    this.meetingType = 1,

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
    this.meetingDetails = const MeetingDetails(),
    this.isFirstTime = true,
    this.assignmentAssignStudentForEdit = const [],
  });

  final int meetingId;
  final bool loading, batchLoading;
  final Forms forms;
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final String link;
  final List<AgendaInput> agenda;
  final int meetingType;

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
  //End dependable dropdown

  final List<int> assignToBatchId;
  final List<String> selectedBatchName;
  final String selecteClassName;
  final List<BatchWiseStudent> batchWiseStudent;
  // final List<BatchWiseStudent> tempBatchWiseStudent;
  final List<List<CheckUncheckStudents>> listOfCheckUncheckStudent;
  final MeetingDetails meetingDetails;
  final bool isFirstTime;
  final List<AssignmentAssignStudent> assignmentAssignStudentForEdit;

  MeetingCreateState copyWith({
    int? meetingId,
    bool? loading,
    Forms? forms,
    bool? batchLoading,
    String? title,
    String? date,
    String? startTime,
    String? endTime,
    String? link,
    List<AgendaInput>? agenda,
    int? meetingType,

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
    MeetingDetails? meetingDetails,
    bool? isFirstTime,
    List<AssignmentAssignStudent>? assignmentAssignStudentForEdit,
  }) {
    return MeetingCreateState(
      meetingId: meetingId ?? this.meetingId,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      batchLoading: batchLoading ?? this.batchLoading,
      title: title ?? this.title,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      link: link ?? this.link,
      agenda: agenda ?? this.agenda,
      meetingType: meetingType ?? this.meetingType,

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
      meetingDetails: meetingDetails ?? this.meetingDetails,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      assignmentAssignStudentForEdit:
          assignmentAssignStudentForEdit ?? this.assignmentAssignStudentForEdit,
    );
  }

  @override
  List<Object> get props => [
        meetingId,
        loading,
        forms,
        batchLoading,
        title,
        date,
        startTime,
        endTime,
        link,
        agenda,
        meetingType,
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
        listOfCheckUncheckStudent,
        meetingDetails,
        isFirstTime,
        assignmentAssignStudentForEdit,
      ];
}

final class MeetingCreateInitial extends MeetingCreateState {}
