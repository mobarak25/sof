part of 'teacher_exam_create_bloc.dart';

class TeacherExamCreateState extends Equatable {
  const TeacherExamCreateState({
    this.examId = -1,
    this.loading = false,
    this.forms = Forms.initial,
    this.examDate = '',

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

    this.examDtls = const ExamDetails(),
    this.isFirstTime = true,
  });

  final int examId;
  final bool loading;
  final Forms forms;
  final String examDate;

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

  final ExamDetails examDtls;
  final bool isFirstTime;

  TeacherExamCreateState copyWith({
    int? examId,
    bool? loading,
    Forms? forms,
    String? examDate,
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
    ExamDetails? examDtls,
    bool? isFirstTime,
  }) {
    return TeacherExamCreateState(
      examId: examId ?? this.examId,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      examDate: examDate ?? this.examDate,
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
        examDtls,
        isFirstTime,
      ];
}

final class TeacherExamCreateInitial extends TeacherExamCreateState {}
