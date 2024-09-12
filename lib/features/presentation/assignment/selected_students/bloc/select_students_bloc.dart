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
    on<ToggleCheckbox>(_toggleCheckbox);
    on<ToggleSelectAll>(_toggleSelectAll);
  }

  FutureOr<void> _getInitialStudents(
      GetInitialStudents event, Emitter<SelectStudentsState> emit) {
    List<bool> selected = [];
    for (int i = 0; i < event.students.data!.length; i++) {
      selected.add(true);
    }
    emit(
        state.copyWith(allStudents: event.students, selectedOptions: selected));
  }

  FutureOr<void> _toggleCheckbox(
      ToggleCheckbox event, Emitter<SelectStudentsState> emit) {
    final updatedOptions = List<bool>.from(state.selectedOptions);
    updatedOptions[event.index] = event.value;
    emit(state.copyWith(selectedOptions: updatedOptions));

    bool selectAll = state.selectedOptions.every((item) => item);
    emit(state.copyWith(selectAll: selectAll));
  }

  FutureOr<void> _toggleSelectAll(
      ToggleSelectAll event, Emitter<SelectStudentsState> emit) {
    emit(state.copyWith(
        selectAll: event.value,
        selectedOptions: List.generate(
            state.selectedOptions.length, (index) => event.value)));
  }
}
