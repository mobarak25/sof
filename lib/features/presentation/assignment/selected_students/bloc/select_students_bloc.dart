import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/utils/utilities.dart';

part 'select_students_event.dart';
part 'select_students_state.dart';

class SelectStudentsBloc
    extends Bloc<SelectStudentsEvent, SelectStudentsState> {
  SelectStudentsBloc() : super(SelectStudentsInitial()) {
    on<GetInitialStudents>(_getInitialStudents);
    on<ToggleCheckbox>(_toggleCheckbox);
    on<ToggleSelectAll>(_toggleSelectAll);
    on<ChageSearch>(_chageSearch);
  }

  FutureOr<void> _getInitialStudents(
      GetInitialStudents event, Emitter<SelectStudentsState> emit) {
    bool selectAll = event.students.every((item) => item.isChecked);
    emit(state.copyWith(allStudents: event.students, selectAll: selectAll));
  }

  FutureOr<void> _toggleCheckbox(
      ToggleCheckbox event, Emitter<SelectStudentsState> emit) {
    final updatedOptions = List<CheckUncheckStudents>.from(state.allStudents);

    updatedOptions[event.index] = CheckUncheckStudents(
      id: updatedOptions[event.index].id,
      isChecked: event.value,
      name: updatedOptions[event.index].name,
      admissionRoll: updatedOptions[event.index].admissionRoll,
    );

    emit(state.copyWith(allStudents: updatedOptions));

    bool selectAll = state.allStudents.every((item) => item.isChecked);
    emit(state.copyWith(selectAll: selectAll));
  }

  FutureOr<void> _toggleSelectAll(
      ToggleSelectAll event, Emitter<SelectStudentsState> emit) {
    emit(
      state.copyWith(
        selectAll: event.value,
        allStudents: List.generate(
          state.allStudents.length,
          (index) => CheckUncheckStudents(
            id: state.allStudents[index].id,
            isChecked: event.value,
            name: state.allStudents[index].name,
            admissionRoll: state.allStudents[index].admissionRoll,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _chageSearch(
      ChageSearch event, Emitter<SelectStudentsState> emit) {
    if (event.search.isNotEmpty) {
      emit(state.copyWith(
          allStudents: state.allStudents
              .where((item) =>
                  item.name.toLowerCase().contains(event.search.toLowerCase()))
              .toList()));
    }
  }
}
