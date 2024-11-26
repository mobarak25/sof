part of 'teacher_exam_create_bloc.dart';

class TeacherExamCreateState extends Equatable {
  const TeacherExamCreateState({
    this.examId = -1,
    this.loading = false,
    this.forms = Forms.initial,
    this.examDate = '',
    this.startTime = '',
    this.endTime = '',
    this.maxMark = '',
    this.convertMark = '',
    this.passMark = '',

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
    this.sectionList = const [DropdownItem(name: 'Select', value: -1)],
    //End dependable
    this.setGroup = false,
    this.setTerm = false,
    this.selectedExamGorupId = -1,
    this.selectTermId = -1,
    this.groupList = const [DropdownItem(name: 'Select', value: -1)],
    this.termList = const [DropdownItem(name: 'Select', value: -1)],
    this.examDtls = const ExamDetails(),
    this.isFirstTime = true,
  });

  final int examId;
  final bool loading;
  final Forms forms;
  final String examDate;
  final String startTime;
  final String endTime;
  final String maxMark;
  final String convertMark;
  final String passMark;

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
  final List<DropdownItem> sectionList;
  //End dependable dropdown
  final bool setGroup;
  final bool setTerm;
  final dynamic selectedExamGorupId;
  final dynamic selectTermId;
  final List<DropdownItem> groupList;
  final List<DropdownItem> termList;

  final ExamDetails examDtls;
  final bool isFirstTime;

  TeacherExamCreateState copyWith({
    int? examId,
    bool? loading,
    Forms? forms,
    String? examDate,
    String? startTime,
    String? endTime,
    String? maxMark,
    String? convertMark,
    String? passMark,
    //dependable dropdown
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
    List<DropdownItem>? sectionList,
    //End dependable dropdown
    bool? setGroup,
    bool? setTerm,
    dynamic selectedExamGorupId,
    dynamic selectTermId,
    List<DropdownItem>? groupList,
    List<DropdownItem>? termList,
    ExamDetails? examDtls,
    bool? isFirstTime,
  }) {
    return TeacherExamCreateState(
      examId: examId ?? this.examId,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      examDate: examDate ?? this.examDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      maxMark: maxMark ?? this.maxMark,
      convertMark: convertMark ?? this.convertMark,
      passMark: passMark ?? this.passMark,
      //
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
      //
      setGroup: setGroup ?? false,
      setTerm: setTerm ?? false,
      selectedExamGorupId: selectedExamGorupId ?? this.selectedExamGorupId,
      selectTermId: selectTermId ?? this.selectTermId,
      groupList: groupList ?? this.groupList,
      termList: termList ?? this.termList,
      examDtls: examDtls ?? this.examDtls,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  @override
  List<Object> get props => [
        examId,
        loading,
        forms,
        examDate,
        startTime,
        endTime,
        maxMark,
        convertMark,
        passMark,
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
        setGroup,
        setTerm,
        selectedExamGorupId,
        selectTermId,
        groupList,
        termList,
        examDtls,
        isFirstTime,
      ];
}

final class TeacherExamCreateInitial extends TeacherExamCreateState {}
