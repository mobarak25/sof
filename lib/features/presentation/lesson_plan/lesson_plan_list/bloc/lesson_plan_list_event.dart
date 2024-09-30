part of 'lesson_plan_list_bloc.dart';

sealed class LessonPlanListEvent extends Equatable {
  const LessonPlanListEvent();

  @override
  List<Object> get props => [];
}

class IsTeacher extends LessonPlanListEvent {}

class DataForTab extends LessonPlanListEvent {
  const DataForTab({required this.tabIndex, required this.filterBloc});
  final String tabIndex;
  final FilterSidebarBloc filterBloc;
}

class ChangeSearch extends LessonPlanListEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class GetSearchedLessonPlan extends LessonPlanListEvent {
  const GetSearchedLessonPlan({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PressToDelEdit extends LessonPlanListEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteLessonPlan extends LessonPlanListEvent {
  const DeleteLessonPlan({required this.planId});
  final int planId;
}

class PressFilter extends LessonPlanListEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PageIncrement extends LessonPlanListEvent {
  const PageIncrement({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}
