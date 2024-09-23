part of 'classwork_list_bloc.dart';

class ClassworkListState extends Equatable {
  const ClassworkListState({
    this.page = 1,
    this.loading = false,
    this.isFirst = true,
    this.isTeacher = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.activeTab = '0',
    this.searchText = '',
    this.classworkList = const ClassworkList(),
  });

  final int page;
  final bool loading;
  final bool isFirst;
  final bool isTeacher;
  final bool isEndList;
  final bool incrementLoader;
  final String activeTab;
  final String searchText;
  final ClassworkList classworkList;

  ClassworkListState copyWith({
    int? page,
    bool? loading,
    bool? isFirst,
    bool? isTeacher,
    bool? isEndList,
    bool? incrementLoader,
    String? activeTab,
    String? searchText,
    ClassworkList? classworkList,
  }) {
    return ClassworkListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isFirst: isFirst ?? this.isFirst,
      isTeacher: isTeacher ?? this.isTeacher,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      activeTab: activeTab ?? this.activeTab,
      searchText: searchText ?? this.searchText,
      classworkList: classworkList ?? this.classworkList,
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
        classworkList,
      ];
}

final class ClassworkListInitial extends ClassworkListState {}
