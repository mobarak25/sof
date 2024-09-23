part of 'student_classwork_list_bloc.dart';

class StudentClassworkListState extends Equatable {
  const StudentClassworkListState({
    this.page = 1,
    this.loading = false,
    this.isFirst = true,
    this.isEndList = false,
    this.incrementLoader = false,
    this.subjectId = -1,
    this.activeTab = '0',
    this.searchText = '',
    this.publishedAt = '',
    this.classworkList = const ClassworkList(),
  });

  final int page;
  final bool loading;
  final bool isFirst;
  final bool isEndList;
  final int subjectId;
  final bool incrementLoader;
  final String activeTab;
  final String searchText;
  final String publishedAt;
  final ClassworkList classworkList;

  StudentClassworkListState copyWith({
    int? page,
    bool? loading,
    bool? isFirst,
    bool? isEndList,
    bool? incrementLoader,
    int? subjectId,
    String? activeTab,
    String? searchText,
    String? publishedAt,
    ClassworkList? classworkList,
  }) {
    return StudentClassworkListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isFirst: isFirst ?? this.isFirst,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      subjectId: subjectId ?? this.subjectId,
      activeTab: activeTab ?? this.activeTab,
      searchText: searchText ?? this.searchText,
      publishedAt: publishedAt ?? this.publishedAt,
      classworkList: classworkList ?? this.classworkList,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isFirst,
        isEndList,
        incrementLoader,
        subjectId,
        activeTab,
        searchText,
        publishedAt,
        classworkList,
      ];
}

final class StudentClassworkListInitial extends StudentClassworkListState {}
