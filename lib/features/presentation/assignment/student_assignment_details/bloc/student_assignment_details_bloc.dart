import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/assignment_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';

part 'student_assignment_details_event.dart';
part 'student_assignment_details_state.dart';

class StudentAssignmentDetailsBloc
    extends Bloc<StudentAssignmentDetailsEvent, StudentAssignmentDetailsState> {
  StudentAssignmentDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentAssignmentDetailsInitial()) {
    on<GetDetails>(_getDetails);
    on<CheckTeacher>(_checkTeacher);

    add(CheckTeacher());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getDetails(
      GetDetails event, Emitter<StudentAssignmentDetailsState> emit) async {
    print(event.assingmentId);
    final details = await _apiRepo.get<AssignmentDetails>(
      endpoint: assignmentDetailsEndPoint(
          dId: event.assingmentId,
          sId: _localStorageRepo.read(key: loginIdDB)!),
    );

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }

  FutureOr<void> _checkTeacher(
      CheckTeacher event, Emitter<StudentAssignmentDetailsState> emit) async {
    final teacher =
        await LocalData.isTeacher(localStorageRepo: _localStorageRepo);
    emit(state.copyWith(isTeacher: teacher));
  }
}
