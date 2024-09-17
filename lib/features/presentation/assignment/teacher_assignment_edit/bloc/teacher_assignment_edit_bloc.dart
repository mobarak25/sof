import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'teacher_assignment_edit_event.dart';
part 'teacher_assignment_edit_state.dart';

class TeacherAssignmentEditBloc extends Bloc<TeacherAssignmentEditEvent, TeacherAssignmentEditState> {
  TeacherAssignmentEditBloc() : super(TeacherAssignmentEditInitial()) {
    on<TeacherAssignmentEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
