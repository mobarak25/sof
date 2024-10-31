part of 'syllabus_create_bloc.dart';

class SyllabusCreateState extends Equatable {
  const SyllabusCreateState({
    this.loading = false,
    this.syllabusId = -1,
    this.forms = Forms.initial,
    this.title = '',
    this.content = '',
    this.marks = '',
    this.date = '',
    this.fileList = const [],
    this.isFirstTime = true,
    this.details = const SyllabusDetails(),
    this.syllabusType = -1,
    //dropdown=======
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
    this.bacthAsSection = const GetBacthAsSections(),
    //End dropdown=======
  });

  final bool loading;
  final int syllabusId;
  final Forms forms;
  final String title;
  final String content;
  final String marks;
  final String date;
  final List<File> fileList;
  final bool isFirstTime;
  final SyllabusDetails details;
  final dynamic syllabusType;
//dropdown=======
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
  final GetBacthAsSections bacthAsSection;
  //End dropdown=======

  SyllabusCreateState copyWith({
    bool? loading,
    int? syllabusId,
    Forms? forms,
    String? title,
    String? content,
    String? marks,
    String? date,
    List<File>? fileList,
    bool? isFirstTime,
    SyllabusDetails? details,
    dynamic syllabusType,
    //dropdown=======
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
    GetBacthAsSections? bacthAsSection,
    //end dropdown=======
  }) {
    return SyllabusCreateState(
      loading: loading ?? this.loading,
      syllabusId: syllabusId ?? this.syllabusId,
      forms: forms ?? this.forms,
      title: title ?? this.title,
      content: content ?? this.content,
      marks: marks ?? this.marks,
      date: date ?? this.date,
      fileList: fileList ?? this.fileList,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      details: details ?? this.details,
      syllabusType: syllabusType ?? this.syllabusType,
      //dropdown=======
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
      bacthAsSection: bacthAsSection ?? this.bacthAsSection,
      //End dropdown=======
    );
  }

  @override
  List<Object> get props => [
        loading,
        syllabusId,
        forms,
        title,
        content,
        marks,
        date,
        fileList,
        isFirstTime,
        details,
        syllabusType,
        //dropdown=======
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
        bacthAsSection,
        //end dropdown=======
      ];
}

final class SyllabusCreateInitial extends SyllabusCreateState {}
