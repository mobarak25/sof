import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/student_leave_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'leave_details_event.dart';
part 'leave_details_state.dart';

class LeaveDetailsBloc extends Bloc<LeaveDetailsEvent, LeaveDetailsState> {
  LeaveDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(LeaveDetailsInitial()) {
    on<GetLeaveDetails>(_getLeaveDetails);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getLeaveDetails(
      GetLeaveDetails event, Emitter<LeaveDetailsState> emit) async {
    final details = await _apiRepo.get<StudentLeaveLDetails>(
        endpoint: studentLeaveDtlsEndPoint(id: event.leaveId));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
