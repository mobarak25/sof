part of 'filter_sidebar_bloc.dart';

class FilterSidebarState extends Equatable {
  const FilterSidebarState({
    this.isTeacher = false,
    this.startDate = '',
    this.endDate = '',
    this.setClass = false,
    this.setSubject = false,
    this.setSection = false,
    this.setChapter = false,
    this.selectedVersionId = -1,
    this.selectedClassId = -1,
    this.selectedSubjectId = -1,
    this.selectSectionId = -1,
    this.selectChapterId = -1,
    this.selectSubjectIdForStudent = -1,
    this.versionList = const [DropdownItem(name: 'Select', value: -1)],
    this.classList = const [DropdownItem(name: 'Select', value: -1)],
    this.subjectList = const [DropdownItem(name: 'Select', value: -1)],
    this.sectionList = const [DropdownItem(name: 'Select', value: -1)],
    this.chapterList = const [DropdownItem(name: 'Select', value: -1)],
    this.studentSubjectList = const [DropdownItem(name: 'Select', value: -1)],
    this.bacthAsSection = const GetBacthAsSections(),
  });

  final bool isTeacher;
  final String startDate;
  final String endDate;
  final bool setClass;
  final bool setSubject;
  final bool setSection;
  final bool setChapter;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectSectionId;
  final dynamic selectChapterId;
  final dynamic selectSubjectIdForStudent;
  final List<DropdownItem> versionList;
  final List<DropdownItem> classList;
  final List<DropdownItem> subjectList;
  final List<DropdownItem> sectionList;
  final List<DropdownItem> chapterList;
  final List<DropdownItem> studentSubjectList;
  final GetBacthAsSections bacthAsSection;

  FilterSidebarState copyWith({
    bool? isTeacher,
    String? startDate,
    String? endDate,
    bool? setClass,
    bool? setSubject,
    bool? setSection,
    bool? setChapter,
    dynamic selectedVersionId,
    dynamic selectedClassId,
    dynamic selectedSubjectId,
    dynamic selectSectionId,
    dynamic selectChapterId,
    dynamic selectSubjectIdForStudent,
    List<DropdownItem>? versionList,
    List<DropdownItem>? classList,
    List<DropdownItem>? subjectList,
    List<DropdownItem>? sectionList,
    List<DropdownItem>? chapterList,
    List<DropdownItem>? studentSubjectList,
    GetBacthAsSections? bacthAsSection,
  }) {
    return FilterSidebarState(
      isTeacher: isTeacher ?? this.isTeacher,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      setClass: setClass ?? false,
      setSubject: setSubject ?? false,
      setSection: setSection ?? false,
      setChapter: setChapter ?? false,
      selectedVersionId: selectedVersionId ?? this.selectedVersionId,
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      selectSectionId: selectSectionId ?? this.selectSectionId,
      selectChapterId: selectChapterId ?? this.selectChapterId,
      selectSubjectIdForStudent:
          selectSubjectIdForStudent ?? this.selectSubjectIdForStudent,
      versionList: versionList ?? this.versionList,
      classList: classList ?? this.classList,
      subjectList: subjectList ?? this.subjectList,
      sectionList: sectionList ?? this.sectionList,
      chapterList: chapterList ?? this.chapterList,
      studentSubjectList: studentSubjectList ?? this.studentSubjectList,
      bacthAsSection: bacthAsSection ?? this.bacthAsSection,
    );
  }

  @override
  List<Object> get props => [
        startDate,
        endDate,
        setClass,
        setSubject,
        setSection,
        setChapter,
        selectedVersionId,
        selectedClassId,
        selectedSubjectId,
        selectSectionId,
        selectChapterId,
        selectSubjectIdForStudent,
        versionList,
        classList,
        subjectList,
        sectionList,
        chapterList,
        studentSubjectList,
        bacthAsSection,
      ];
}

final class FilterSidebarInitial extends FilterSidebarState {}
