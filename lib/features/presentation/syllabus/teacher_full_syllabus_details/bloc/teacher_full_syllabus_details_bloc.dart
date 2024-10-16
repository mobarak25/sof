import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'teacher_full_syllabus_details_event.dart';
part 'teacher_full_syllabus_details_state.dart';

class TeacherFullSyllabusDetailsBloc extends Bloc<TeacherFullSyllabusDetailsEvent, TeacherFullSyllabusDetailsState> {
  TeacherFullSyllabusDetailsBloc() : super(TeacherFullSyllabusDetailsInitial()) {
    on<TeacherFullSyllabusDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
