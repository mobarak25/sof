import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/absent_students_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'absent_student_event.dart';
part 'absent_student_state.dart';

class AbsentStudentBloc extends Bloc<AbsentStudentEvent, AbsentStudentState> {
  AbsentStudentBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(AbsentStudentInitial()) {
    on<GetStudents>(_getStudents);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getStudents(
      GetStudents event, Emitter<AbsentStudentState> emit) async {
    final queryParams = {
      'date': getDate(value: DateTime.now().toString(), formate: "yyyy-MM-dd"),
      'subject_id': event.subjectId,
      'batch_id': event.batchId,
    };

    final student = await _apiRepo.get<AbsentStudents>(
      endpoint: buildUrl(absentStudentsEndPoint, queryParams),
    );

    if (student != null) {
      emit(state.copyWith(students: student));
    }
  }
}
