import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/attendance_overvview_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_attendance_event.dart';
part 'teacher_attendance_state.dart';

class TeacherAttendanceBloc
    extends Bloc<TeacherAttendanceEvent, TeacherAttendanceState> {
  TeacherAttendanceBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherAttendanceInitial()) {
    on<GetBactch>(_getBactch);
    on<DataForTab>(_dataForTab);
    on<GetIdList>(_getIdList);
    on<GetDate>(_getDate);

    add(GetBactch());
    add(DataForTab(tabIndex: state.activeTab));
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getBactch(
      GetBactch event, Emitter<TeacherAttendanceState> emit) async {
    final batchList = await _apiRepo.get<GetBacthAsSections>(
        endpoint: getBatchAsSectionsEndPoint);
    if (batchList != null) {
      emit(state.copyWith(bacthAsSection: batchList));
    }
  }

  FutureOr<void> _getDate(GetDate event, Emitter<TeacherAttendanceState> emit) {
    final String date =
        getDate(value: event.date.toString(), formate: "yyyy-MM-dd");
    emit(state.copyWith(date: date));

    add(GetIdList(
      subjectId: state.subjectId,
      batchId: state.batchId,
      className: state.className,
    ));
  }

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<TeacherAttendanceState> emit) async {
    emit(state.copyWith(loading: false, activeTab: event.tabIndex));
  }

  FutureOr<void> _getIdList(
      GetIdList event, Emitter<TeacherAttendanceState> emit) async {
    emit(state.copyWith(
        subjectId: event.subjectId,
        batchId: event.batchId,
        className: event.className,
        isFirstTime: false));

    final queryParams = {
      'date': state.date.isEmpty
          ? getDate(value: DateTime.now().toString(), formate: "yyyy-MM-dd")
          : state.date,
      'subject_id': state.subjectId,
      'batch_id': state.batchId,
    };
    final overView = await _apiRepo.get<AttendanceOverview>(
        endpoint: buildUrl(subjectWiseAttendanceEndPoint, queryParams));

    if (overView != null) {
      emit(state.copyWith(attendanceOverview: overView));
    }
  }
}
