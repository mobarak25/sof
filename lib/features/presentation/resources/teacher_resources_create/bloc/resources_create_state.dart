part of 'resources_create_bloc.dart';

class ResourcesCreateState extends Equatable {
  const ResourcesCreateState({
    this.resourceId = -1,
    this.loading = false,
    this.forms = Forms.initial,
    this.title = '',
    this.videoLink = '',
    this.fileList = const [],
    this.thumbList = const [],
    //dependable
    this.bacthAsSection = const GetBacthAsSections(),
    this.setClass = false,
    this.setSubject = false,
    this.setChapter = false,
    this.selectedVersionId = -1,
    this.selectedClassId = -1,
    this.selectedSubjectId = -1,
    this.selectedChapterId = -1,
    this.selectedResourceType = -1,
    this.versionList = const [DropdownItem(name: 'Select', value: -1)],
    this.classList = const [DropdownItem(name: 'Select', value: -1)],
    this.subjectList = const [DropdownItem(name: 'Select', value: -1)],
    this.chapterList = const [DropdownItem(name: 'Select', value: -1)],
    this.resourceTypeList = const [DropdownItem(name: 'Select', value: -1)],

    //End dependable

    this.resourceDtls = const ResourceDetails(),
    this.isFirstTime = true,
  });

  final int resourceId;
  final bool loading;
  final Forms forms;
  final String title;
  final String videoLink;
  final List<File> fileList;
  final List<File> thumbList;

  //dependable dropdown
  final GetBacthAsSections bacthAsSection;
  final bool setClass;
  final bool setSubject;
  final bool setChapter;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectedChapterId;
  final dynamic selectedResourceType;
  final List<DropdownItem> versionList;
  final List<DropdownItem> classList;
  final List<DropdownItem> subjectList;
  final List<DropdownItem> chapterList;
  final List<DropdownItem> resourceTypeList;
  //End dependable dropdown

  final ResourceDetails resourceDtls;
  final bool isFirstTime;

  ResourcesCreateState copyWith({
    int? resourceId,
    bool? loading,
    Forms? forms,
    List<File>? fileList,
    List<File>? thumbList,
    String? title,
    String? videoLink,

    //
    GetBacthAsSections? bacthAsSection,
    bool? setClass,
    bool? setSubject,
    bool? setChapter,
    dynamic selectedVersionId,
    dynamic selectedClassId,
    dynamic selectedSubjectId,
    dynamic selectedChapterId,
    dynamic selectedResourceType,
    List<DropdownItem>? versionList,
    List<DropdownItem>? classList,
    List<DropdownItem>? subjectList,
    List<DropdownItem>? chapterList,
    List<DropdownItem>? resourceTypeList,
    //

    ResourceDetails? resourceDtls,
    bool? isFirstTime,
  }) {
    return ResourcesCreateState(
      resourceId: resourceId ?? this.resourceId,
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      title: title ?? this.title,
      videoLink: videoLink ?? this.videoLink,
      fileList: fileList ?? this.fileList,
      thumbList: thumbList ?? this.thumbList,

      //dropdown
      bacthAsSection: bacthAsSection ?? this.bacthAsSection,
      setClass: setClass ?? false,
      setSubject: setSubject ?? false,
      setChapter: setChapter ?? false,
      selectedVersionId: selectedVersionId ?? this.selectedVersionId,
      selectedClassId: selectedClassId ?? this.selectedClassId,
      selectedSubjectId: selectedSubjectId ?? this.selectedSubjectId,
      selectedChapterId: selectedChapterId ?? this.selectedChapterId,
      selectedResourceType: selectedResourceType ?? this.selectedResourceType,
      versionList: versionList ?? this.versionList,
      classList: classList ?? this.classList,
      subjectList: subjectList ?? this.subjectList,
      chapterList: chapterList ?? this.chapterList,
      resourceTypeList: resourceTypeList ?? this.resourceTypeList,

      //End dropdown

      resourceDtls: resourceDtls ?? this.resourceDtls,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  @override
  List<Object> get props => [
        resourceId,
        loading,
        forms,
        title,
        videoLink,
        fileList,
        thumbList,

        //dropdown
        bacthAsSection,
        setClass,
        setSubject,
        setChapter,
        selectedVersionId,
        selectedClassId,
        selectedSubjectId,
        selectedChapterId,
        selectedResourceType,
        versionList,
        classList,
        subjectList,
        chapterList,
        resourceTypeList,
        //end dropdown

        resourceDtls,
        isFirstTime,
      ];
}

final class ResourcesCreateInitial extends ResourcesCreateState {}
