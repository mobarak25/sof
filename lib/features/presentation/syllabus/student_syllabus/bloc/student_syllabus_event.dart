part of 'student_syllabus_bloc.dart';

sealed class StudentSyllabusEvent extends Equatable {
  const StudentSyllabusEvent();

  @override
  List<Object> get props => [];
}

class DataForTab extends StudentSyllabusEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}

class PressContinue extends StudentSyllabusEvent {}

class PageIncrement extends StudentSyllabusEvent {}
