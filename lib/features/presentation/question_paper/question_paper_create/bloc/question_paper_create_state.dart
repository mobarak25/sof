part of 'question_paper_create_bloc.dart';

class QuestionPaperCreateState extends Equatable {
  const QuestionPaperCreateState({
    this.qPaperId = -1,
    this.loading = false,
    this.forms = Forms.initial,
    this.title = '',
    this.startDate = '',
    this.paperType = '',
    this.duration = '',

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
    this.questionDtls = const QuestionPaperDtls(),
    this.isFirstTime = true,
    this.selectedQstns = const [],
    this.fullMarks = 0,
  });

  final int qPaperId;
  final bool loading;
  final Forms forms;
  final String title;
  final String startDate;
  final String paperType;
  final String duration;
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
  final QuestionPaperDtls questionDtls;
  final bool isFirstTime;
  final List<TempQuestion> selectedQstns;
  final num fullMarks;

  QuestionPaperCreateState copyWith({
    int? qPaperId,
    bool? loading,
    Forms? forms,
    String? title,
    String? startDate,
    String? paperType,
    String? duration,
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
    QuestionPaperDtls? questionDtls,
    bool? isFirstTime,
    List<TempQuestion>? selectedQstns,
    num? fullMarks,
  }) {
    return QuestionPaperCreateState(
      qPaperId: qPaperId ?? this.qPaperId,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      paperType: paperType ?? this.paperType,
      duration: duration ?? this.duration,
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
      questionDtls: questionDtls ?? this.questionDtls,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      selectedQstns: selectedQstns ?? this.selectedQstns,
      fullMarks: fullMarks ?? this.fullMarks,
    );
  }

  @override
  List<Object> get props => [
        qPaperId,
        loading,
        forms,
        title,
        startDate,
        paperType,
        duration,

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
        questionDtls,
        isFirstTime,
        selectedQstns,
        fullMarks,
      ];
}

final class QuestionPaperCreateInitial extends QuestionPaperCreateState {}
