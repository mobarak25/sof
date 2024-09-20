part of 'filter_sidebar_bloc.dart';

class FilterSidebarState extends Equatable {
  const FilterSidebarState({
    this.startDate = '',
    this.endDate = '',
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
  });

  final String startDate;
  final String endDate;
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

  FilterSidebarState copyWith({
    String? startDate,
    String? endDate,
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
  }) {
    return FilterSidebarState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
    );
  }

  @override
  List<Object> get props => [
        startDate,
        endDate,
        setClass,
        setSubject,
        setSection,
        selectedVersionId,
        selectedClassId,
        selectedSubjectId,
        versionList,
        classList,
        subjectList,
        sectionList,
        bacthAsSection,
      ];
}

final class FilterSidebarInitial extends FilterSidebarState {}
