part of 'syllabus_class_quiz_bloc.dart';

sealed class SyllabusClassQuizEvent extends Equatable {
  const SyllabusClassQuizEvent();

  @override
  List<Object> get props => [];
}

class GetList extends SyllabusClassQuizEvent {
  const GetList({required this.queryParams});
  final Map<String, dynamic> queryParams;
}

class PressToDelete extends SyllabusClassQuizEvent {
  const PressToDelete({required this.type, required this.id});
  final String type;
  final int id;
}
