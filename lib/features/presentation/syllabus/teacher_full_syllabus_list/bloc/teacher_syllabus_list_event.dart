part of 'teacher_syllabus_list_bloc.dart';

sealed class TeacherSyllabusListEvent extends Equatable {
  const TeacherSyllabusListEvent();

  @override
  List<Object> get props => [];
}

class DataForTab extends TeacherSyllabusListEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}
