part of 'teacher_syllabus_list_bloc.dart';

sealed class TeacherSyllabusListEvent extends Equatable {
  const TeacherSyllabusListEvent();

  @override
  List<Object> get props => [];
}

class IsTeacher extends TeacherSyllabusListEvent {}

class DataForTab extends TeacherSyllabusListEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}

class PressToDelEdit extends TeacherSyllabusListEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteSyllabus extends TeacherSyllabusListEvent {
  const DeleteSyllabus({required this.classworkId});
  final int classworkId;
}

class PressContinue extends TeacherSyllabusListEvent {}

class PageIncrement extends TeacherSyllabusListEvent {}
