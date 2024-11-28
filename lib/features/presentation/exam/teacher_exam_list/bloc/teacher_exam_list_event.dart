part of 'teacher_exam_list_bloc.dart';

sealed class TeacherExamListEvent extends Equatable {
  const TeacherExamListEvent();

  @override
  List<Object> get props => [];
}

class IsTeacher extends TeacherExamListEvent {}

class GetExamList extends TeacherExamListEvent {}

class ChangeSearch extends TeacherExamListEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class PressFilter extends TeacherExamListEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PressToDelEdit extends TeacherExamListEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteQuestion extends TeacherExamListEvent {
  const DeleteQuestion({required this.examId});
  final int examId;
}

class PageIncrement extends TeacherExamListEvent {}
