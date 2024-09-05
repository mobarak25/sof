import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/assignment_details_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_summited_assinent_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_view_submission_event.dart';
part 'teacher_view_submission_state.dart';

class TeacherViewSubmissionBloc
    extends Bloc<TeacherViewSubmissionEvent, TeacherViewSubmissionState> {
  TeacherViewSubmissionBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherViewSubmissionInitial()) {
    on<GetAssignmentDtls>(_getAssignmentDtls);
    on<GetSubmissionList>(_getSubmissionList);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getAssignmentDtls(
      GetAssignmentDtls event, Emitter<TeacherViewSubmissionState> emit) async {
    final details = await _apiRepo.get<AssignmentDetails>(
      endpoint: assignmentDetailsEndPoint(
          dId: event.id, sId: _localStorageRepo.read(key: loginIdDB)!),
    );

    if (details != null) {
      emit(state.copyWith(details: details));
      add(GetSubmissionList(id: event.id));
    }
  }

  FutureOr<void> _getSubmissionList(
      GetSubmissionList event, Emitter<TeacherViewSubmissionState> emit) async {
    final list = await _apiRepo.get<TeacherSummitedAssinentView>(
        endpoint: assignmentMarkEntryEndPoint(id: event.id));

    List<TextEditingController> controllerList = [];

    if (list != null) {
      for (int i = 0; i < list.data!.length; i++) {
        controllerList
            .add(TextEditingController(text: list.data![i].submission!.marks!));
      }
      emit(state.copyWith(submittedList: list, controllers: controllerList));
    }
  }
}
