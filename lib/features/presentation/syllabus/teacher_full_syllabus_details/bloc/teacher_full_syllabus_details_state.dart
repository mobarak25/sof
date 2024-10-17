part of 'teacher_full_syllabus_details_bloc.dart';

class TeacherFullSyllabusDetailsState extends Equatable {
  const TeacherFullSyllabusDetailsState({
    this.details = const FullSyllabusDetails(),
  });

  final FullSyllabusDetails details;

  TeacherFullSyllabusDetailsState copyWith({FullSyllabusDetails? details}) {
    return TeacherFullSyllabusDetailsState(
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [details];
}

final class TeacherFullSyllabusDetailsInitial
    extends TeacherFullSyllabusDetailsState {}
