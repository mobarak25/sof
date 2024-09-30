part of 'lesson_plan_list_bloc.dart';

class LessonPlanListState extends Equatable {
  const LessonPlanListState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.isTeacher = false,
    this.incrementLoader = false,
    this.isFirst = true,
    this.activeTab = '0',
    this.searchText = '',
    this.lessonPlanList = const LessonPlan(),
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final bool isTeacher;
  final bool incrementLoader;
  final bool isFirst;
  final String activeTab;
  final String searchText;
  final LessonPlan lessonPlanList;

  LessonPlanListState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    bool? isTeacher,
    bool? incrementLoader,
    String? activeTab,
    bool? isFirst,
    String? searchText,
    LessonPlan? lessonPlanList,
  }) {
    return LessonPlanListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      isTeacher: isTeacher ?? this.isTeacher,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      activeTab: activeTab ?? this.activeTab,
      isFirst: isFirst ?? this.isFirst,
      searchText: searchText ?? this.searchText,
      lessonPlanList: lessonPlanList ?? this.lessonPlanList,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isEndList,
        isTeacher,
        incrementLoader,
        activeTab,
        searchText,
        isFirst,
        lessonPlanList
      ];
}

final class LessonPlanListInitial extends LessonPlanListState {}
