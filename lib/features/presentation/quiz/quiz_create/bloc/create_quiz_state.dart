part of 'create_quiz_bloc.dart';

class CreateQuizState extends Equatable {
  const CreateQuizState({
    this.quizId = -1,
    this.loading = false,
    this.forms = Forms.initial,
    this.batchLoading = false,
    this.title = '',
    this.startDate = '',
    this.endDate = '',
    this.duration = '',
    this.passPercentage = '',
    this.graceTime = '',
    this.isCommon = true,
    this.allowLateSub = true,
    this.isMarkEditable = true,
    this.allowRetake = true,

    //dependable
    this.bacthAsSection = const GetBacthAsSections(),
    this.setClass = false,
    this.setSubject = false,
    this.setSection = false,
    this.selectedVersionId = -1,
    this.selectedClassId = -1,
    this.selectedSubjectId = -1,
    this.selectSectionId = -1,
    this.selectLevelId = -1,
    this.versionList = const [DropdownItem(name: 'Select', value: -1)],
    this.classList = const [DropdownItem(name: 'Select', value: -1)],
    this.subjectList = const [DropdownItem(name: 'Select', value: -1)],
    this.questionLevel = const [DropdownItem(name: 'Select', value: -1)],
    this.sectionList = const [],
    this.assignToBatchId = const [],
    this.selectedBatchName = const [],
    this.selecteClassName = '',
    this.batchWiseStudent = const [],
    //End dependable
    // this.tempBatchWiseStudent = const [], //may be no need
    this.listOfCheckUncheckStudent = const [],
    this.quizDtls = const QuizDetailsForTeacher(),
    this.isFirstTime = true,
    this.assignmentAssignStudentForEdit = const [],
    this.selectedQstns = const [],
    this.fullMarks = 0,
    this.isSectionEdit = false,
  });

  final int quizId;
  final bool loading, batchLoading;
  final Forms forms;
  final String title;
  final String startDate;
  final String endDate;
  final String duration;
  final String passPercentage;
  final String graceTime;
  final bool isCommon;
  final bool allowLateSub;
  final bool isMarkEditable;
  final bool allowRetake;
  final bool isSectionEdit;

  //dependable dropdown
  final GetBacthAsSections bacthAsSection;
  final bool setClass;
  final bool setSubject;
  final bool setSection;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectSectionId;
  final dynamic selectLevelId;
  final List<DropdownItem> versionList;
  final List<DropdownItem> classList;
  final List<DropdownItem> subjectList;
  final List<DropdownItem> questionLevel;
  final List<DropDownValueModel> sectionList;
  //final List<DropdownItem> sectionList;
  //End dependable dropdown

  final List<int> assignToBatchId;
  final List<String> selectedBatchName;
  final String selecteClassName;
  final List<BatchWiseStudent> batchWiseStudent;
  // final List<BatchWiseStudent> tempBatchWiseStudent;
  final List<List<CheckUncheckStudents>> listOfCheckUncheckStudent;
  final QuizDetailsForTeacher quizDtls;
  final bool isFirstTime;
  final List<AssignmentAssignStudent> assignmentAssignStudentForEdit;
  final List<TempQuestion> selectedQstns;
  final num fullMarks;

  CreateQuizState copyWith({
    int? quizId,
    bool? loading,
    Forms? forms,
    bool? batchLoading,
    String? title,
    String? startDate,
    String? endDate,
    String? duration,
    String? passPercentage,
    String? graceTime,
    bool? isCommon,
    bool? allowLateSub,
    bool? isMarkEditable,
    bool? allowRetake,
    bool? isSectionEdit,

    //
    GetBacthAsSections? bacthAsSection,
    bool? setClass,
    bool? setSubject,
    bool? setSection,
    dynamic selectedVersionId,
    dynamic selectedClassId,
    dynamic selectedSubjectId,
    dynamic selectSectionId,
    dynamic selectLevelId,
    List<DropdownItem>? versionList,
    List<DropdownItem>? classList,
    List<DropdownItem>? subjectList,
    List<DropdownItem>? questionLevel,
    List<DropDownValueModel>? sectionList,
    //
    List<int>? assignToBatchId,
    List<String>? selectedBatchName,
    String? selecteClassName,
    List<BatchWiseStudent>? batchWiseStudent,
    List<BatchWiseStudent>? tempBatchWiseStudent,
    List<List<CheckUncheckStudents>>? listOfCheckUncheckStudent,
    QuizDetailsForTeacher? quizDtls,
    bool? isFirstTime,
    List<AssignmentAssignStudent>? assignmentAssignStudentForEdit,
    List<TempQuestion>? selectedQstns,
    num? fullMarks,
  }) {
    return CreateQuizState(
      quizId: quizId ?? this.quizId,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      batchLoading: batchLoading ?? this.batchLoading,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      duration: duration ?? this.duration,
      passPercentage: passPercentage ?? this.passPercentage,
      graceTime: graceTime ?? this.graceTime,
      isCommon: isCommon ?? this.isCommon,
      allowLateSub: allowLateSub ?? this.allowLateSub,
      isMarkEditable: isMarkEditable ?? this.isMarkEditable,
      allowRetake: allowRetake ?? this.allowRetake,
      isSectionEdit: isSectionEdit ?? this.isSectionEdit,

      //dropdown
      bacthAsSection: bacthAsSection ?? this.bacthAsSection,
      setClass: setClass ?? false,
      setSubject: setSubject ?? false,
      setSection: setSection ?? false,
      selectedVersionId: selectedVersionId ?? this.selectedVersionId,
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      selectSectionId: selectSectionId ?? this.selectSectionId,
      selectLevelId: selectLevelId ?? this.selectLevelId,
      versionList: versionList ?? this.versionList,
      classList: classList ?? this.classList,
      subjectList: subjectList ?? this.subjectList,
      questionLevel: questionLevel ?? this.questionLevel,
      sectionList: sectionList ?? this.sectionList,
      //End dropdown
      assignToBatchId: assignToBatchId ?? this.assignToBatchId,
      selectedBatchName: selectedBatchName ?? this.selectedBatchName,
      selecteClassName: selecteClassName ?? this.selecteClassName,
      batchWiseStudent: batchWiseStudent ?? this.batchWiseStudent,
      // tempBatchWiseStudent: tempBatchWiseStudent ?? this.tempBatchWiseStudent,
      listOfCheckUncheckStudent:
          listOfCheckUncheckStudent ?? this.listOfCheckUncheckStudent,
      quizDtls: quizDtls ?? this.quizDtls,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      assignmentAssignStudentForEdit:
          assignmentAssignStudentForEdit ?? this.assignmentAssignStudentForEdit,
      selectedQstns: selectedQstns ?? this.selectedQstns,
      fullMarks: fullMarks ?? this.fullMarks,
    );
  }

  @override
  List<Object> get props => [
        quizId,
        loading,
        forms,
        batchLoading,
        title,
        startDate,
        endDate,
        duration,
        passPercentage,
        graceTime,
        isCommon,
        allowLateSub,
        isMarkEditable,
        allowRetake,
        isSectionEdit,

        //dropdown
        bacthAsSection,
        setClass,
        setSubject,
        setSection,
        selectedVersionId,
        selectedClassId,
        selectedSubjectId,
        selectSectionId,
        selectLevelId,
        versionList,
        classList,
        subjectList,
        questionLevel,
        sectionList,
        //end dropdown
        assignToBatchId,
        selectedBatchName,
        selecteClassName,
        batchWiseStudent,
        // tempBatchWiseStudent,
        listOfCheckUncheckStudent,
        quizDtls,
        isFirstTime,
        assignmentAssignStudentForEdit,
        selectedQstns,
        fullMarks,
      ];
}

final class CreateQuizInitial extends CreateQuizState {}
