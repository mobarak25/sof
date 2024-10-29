part of 'question_create_bloc.dart';

class QuestionCreateState extends Equatable {
  const QuestionCreateState({
    this.qId = -1,
    this.loading = false,
    this.forms = Forms.initial,
    this.title = '',
    this.mark = '',
    this.explanation = '',
    this.fileList = const [],
    this.optionImage = const [],
    //dependable
    this.bacthAsSection = const GetBacthAsSections(),
    this.setClass = false,
    this.setSubject = false,
    this.setSection = false,
    this.selectedVersionId = -1,
    this.selectedClassId = -1,
    this.selectedSubjectId = -1,
    this.selectLevelId = -1,
    this.questionTypeId = -1,
    this.versionList = const [DropdownItem(name: 'Select', value: -1)],
    this.classList = const [DropdownItem(name: 'Select', value: -1)],
    this.subjectList = const [DropdownItem(name: 'Select', value: -1)],
    this.questionLevel = const [DropdownItem(name: 'Select', value: -1)],
    //End dependable
    this.questionDtls = const QuestionDetails(),
    this.isFirstTime = true,
    this.mcqOptions = const [],
    this.selectedMcqOption = -1,
    this.hasOptionImg = const [],
    this.checked = const [],
  });

  final int qId;
  final bool loading;
  final Forms forms;
  final String title;
  final String mark;
  final String explanation;
  final List<File> fileList;
  final List<File> optionImage;
  //dependable dropdown
  final GetBacthAsSections bacthAsSection;
  final bool setClass;
  final bool setSubject;
  final bool setSection;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectLevelId;
  final dynamic questionTypeId;
  final List<DropdownItem> versionList;
  final List<DropdownItem> classList;
  final List<DropdownItem> subjectList;
  final List<DropdownItem> questionLevel;
  //End dependable dropdown
  final QuestionDetails questionDtls;
  final bool isFirstTime;
  final List<MCQOptions> mcqOptions;
  final dynamic selectedMcqOption;
  final List<int> hasOptionImg;
  final List<int> checked;

  QuestionCreateState copyWith({
    int? qId,
    bool? loading,
    Forms? forms,
    List<File>? fileList,
    List<File>? optionImage,
    String? title,
    String? mark,
    String? explanation,
    String? videoLink,
    //
    GetBacthAsSections? bacthAsSection,
    bool? setClass,
    bool? setSubject,
    bool? setSection,
    dynamic selectedVersionId,
    dynamic selectedClassId,
    dynamic selectedSubjectId,
    dynamic selectLevelId,
    dynamic questionTypeId,
    List<DropdownItem>? versionList,
    List<DropdownItem>? classList,
    List<DropdownItem>? subjectList,
    List<DropdownItem>? questionLevel,
    //
    QuestionDetails? questionDtls,
    bool? isFirstTime,
    List<MCQOptions>? mcqOptions,
    dynamic selectedMcqOption,
    List<int>? hasOptionImg,
    List<int>? checked,
  }) {
    return QuestionCreateState(
      qId: qId ?? this.qId,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      title: title ?? this.title,
      mark: mark ?? this.mark,
      explanation: explanation ?? this.explanation,
      fileList: fileList ?? this.fileList,
      optionImage: optionImage ?? this.optionImage,
      //dropdown
      bacthAsSection: bacthAsSection ?? this.bacthAsSection,
      setClass: setClass ?? false,
      setSubject: setSubject ?? false,
      setSection: setSection ?? false,
      selectedVersionId: selectedVersionId ?? this.selectedVersionId,
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      selectLevelId: selectLevelId ?? this.selectLevelId,
      questionTypeId: questionTypeId ?? this.questionTypeId,
      versionList: versionList ?? this.versionList,
      classList: classList ?? this.classList,
      subjectList: subjectList ?? this.subjectList,
      questionLevel: questionLevel ?? this.questionLevel,
      //End dropdown
      questionDtls: questionDtls ?? this.questionDtls,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      mcqOptions: mcqOptions ?? this.mcqOptions,
      selectedMcqOption: selectedMcqOption ?? this.selectedMcqOption,
      hasOptionImg: hasOptionImg ?? this.hasOptionImg,
      checked: checked ?? this.checked,
    );
  }

  @override
  List<Object> get props => [
        qId,
        loading,
        forms,
        mark,
        explanation,
        title,
        fileList,
        optionImage,
        //dropdown
        bacthAsSection,
        setClass,
        setSubject,
        setSection,
        selectedVersionId,
        selectedClassId,
        selectedSubjectId,
        selectLevelId,
        questionTypeId,
        versionList,
        classList,
        subjectList,
        questionLevel,
        //end dropdown
        questionDtls,
        isFirstTime,
        mcqOptions,
        selectedMcqOption,
        hasOptionImg,
        checked,
      ];
}

final class QuestionCreateInitial extends QuestionCreateState {}
