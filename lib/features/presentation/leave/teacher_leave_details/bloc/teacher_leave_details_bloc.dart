import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/teacher_leave_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_leave_details_event.dart';
part 'teacher_leave_details_state.dart';

class TeacherLeaveDetailsBloc
    extends Bloc<TeacherLeaveDetailsEvent, TeacherLeaveDetailsState> {
  TeacherLeaveDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherLeaveDetailsInitial()) {
    on<GetTeacherLeaveDetails>(_getLeaveDetails);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getLeaveDetails(GetTeacherLeaveDetails event,
      Emitter<TeacherLeaveDetailsState> emit) async {
    final details = await _apiRepo.get<TeacherLeaveDetails>(
        endpoint: teacherOwnLeaveDtlsEndPoint(id: event.leaveId));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
