part of 'teacher_full_syllabus_details_bloc.dart';

sealed class TeacherFullSyllabusDetailsEvent extends Equatable {
  const TeacherFullSyllabusDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetTeacherSyllabusDetails extends TeacherFullSyllabusDetailsEvent {
  const GetTeacherSyllabusDetails({required this.syllabusId});
  final int syllabusId;
}
