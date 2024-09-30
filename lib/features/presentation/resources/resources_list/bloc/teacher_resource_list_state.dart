part of 'teacher_resource_list_bloc.dart';

class TeacherResourceListState extends Equatable {
  const TeacherResourceListState({
    this.page = 1,
    this.loading = false,
    this.isFirst = true,
    this.isTeacher = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.activeTab = '0',
    this.searchText = '',
    this.resources = const Resources(),
  });

  final int page;
  final bool loading;
  final bool isFirst;
  final bool isTeacher;
  final bool isEndList;
  final bool incrementLoader;
  final String activeTab;
  final String searchText;
  final Resources resources;

  TeacherResourceListState copyWith({
    int? page,
    bool? loading,
    bool? isFirst,
    bool? isTeacher,
    bool? isEndList,
    bool? incrementLoader,
    String? activeTab,
    String? searchText,
    Resources? resources,
  }) {
    return TeacherResourceListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isFirst: isFirst ?? this.isFirst,
      isTeacher: isTeacher ?? this.isTeacher,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      activeTab: activeTab ?? this.activeTab,
      searchText: searchText ?? this.searchText,
      resources: resources ?? this.resources,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isFirst,
        isTeacher,
        isEndList,
        incrementLoader,
        activeTab,
        searchText,
        resources,
      ];
}

final class TeacherResourceListInitial extends TeacherResourceListState {}
