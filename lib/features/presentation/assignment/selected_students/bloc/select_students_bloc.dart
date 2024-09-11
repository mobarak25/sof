import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/features/domain/entities/batch_wise_student.dart';

part 'select_students_event.dart';
part 'select_students_state.dart';

class SelectStudentsBloc
    extends Bloc<SelectStudentsEvent, SelectStudentsState> {
  SelectStudentsBloc() : super(SelectStudentsInitial()) {
    on<GetInitialStudents>(_getInitialStudents);
  }

  FutureOr<void> _getInitialStudents(
      GetInitialStudents event, Emitter<SelectStudentsState> emit) {
    emit(state.copyWith(allStudents: event.students));
  }
}
