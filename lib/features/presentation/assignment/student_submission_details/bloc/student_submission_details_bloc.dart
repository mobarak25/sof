import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/student_assignment_submissign_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'student_submission_details_event.dart';
part 'student_submission_details_state.dart';

class StudentSubmissionDetailsBloc
    extends Bloc<StudentSubmissionDetailsEvent, StudentSubmissionDetailsState> {
  StudentSubmissionDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentSubmissionDetailsInitial()) {
    on<GetSubmissionDetails>(_getSubmissionDetails);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getSubmissionDetails(GetSubmissionDetails event,
      Emitter<StudentSubmissionDetailsState> emit) async {
    final details = await _apiRepo.get<StudentAssignmentDetails>(
        endpoint: submitAssignmentDtlsEndPoint(submitId: event.id));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
