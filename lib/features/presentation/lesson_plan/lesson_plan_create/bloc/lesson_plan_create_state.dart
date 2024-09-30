part of 'lesson_plan_create_bloc.dart';

class LessonPlanCreateState extends Equatable {
  const LessonPlanCreateState({
    this.planId = -1,
    this.loading = false,
    this.forms = Forms.initial,
    this.title = '',
    this.fileList = const [],
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
    this.planDtls = const LessonPlanDetails(),
    this.isFirstTime = true,
    this.checkedIds = const [],
  });

  final int planId;
  final bool loading;
  final Forms forms;
  final String title;
  final List<File> fileList;
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
  final LessonPlanDetails planDtls;
  final bool isFirstTime;
  final List<int> checkedIds;

  LessonPlanCreateState copyWith({
    int? planId,
    bool? loading,
    Forms? forms,
    List<File>? fileList,
    String? title,
    String? videoLink,
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
    List<DropdownItem>? sectionList,
    //
    LessonPlanDetails? planDtls,
    bool? isFirstTime,
    List<int>? checkedIds,
  }) {
    return LessonPlanCreateState(
      planId: planId ?? this.planId,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      title: title ?? this.title,
      fileList: fileList ?? this.fileList,
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
      planDtls: planDtls ?? this.planDtls,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      checkedIds: checkedIds ?? this.checkedIds,
    );
  }

  @override
  List<Object> get props => [
        planId,
        loading,
        forms,
        title,
        fileList,
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
        planDtls,
        isFirstTime,
        checkedIds,
      ];
}

final class LessonPlanCreateInitial extends LessonPlanCreateState {}
