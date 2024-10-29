import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/attendance_overvview_response.dart';
import 'package:school_of_future/features/domain/entities/calander_attendance_overview_response.dart';
import 'package:school_of_future/features/domain/entities/today_attendance_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'student_attendance_event.dart';
part 'student_attendance_state.dart';

class StudentAttendanceBloc
    extends Bloc<StudentAttendanceEvent, StudentAttendanceState> {
  StudentAttendanceBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentAttendanceInitial()) {
    on<GetStudentOverView>(_getStudentOverView);
    on<TodayAttendance>(_todayAttendance);
    on<PressFilter>(_pressFilter);
    on<GetCalanderOverView>(_getCalanderOverView);

    add(GetCalanderOverView(date: DateTime.now()));
    add(TodayAttendance());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getStudentOverView(
      GetStudentOverView event, Emitter<StudentAttendanceState> emit) async {
    emit(state.copyWith(isFirstTime: false));
    final filterBloc = event.filterBloc.state;
    final queryParams = {
      "start_date": filterBloc.startDate.isEmpty
          ? getDate(value: DateTime.now().toString(), formate: "yyyy-MM-dd")
          : filterBloc.startDate,
      "end_date": filterBloc.endDate.isEmpty
          ? getDate(value: DateTime.now().toString(), formate: "yyyy-MM-dd")
          : filterBloc.endDate,
      "subject_id": filterBloc.selectSubjectIdForStudent,
    };

    final report = await _apiRepo.get<AttendanceOverview>(
      endpoint: buildUrl(
          attendanceOverViewEndPoint(
              sId: _localStorageRepo.read(key: loginIdDB)!),
          queryParams),
    );

    if (report != null) {
      emit(state.copyWith(studentOverview: report));
    }
  }

  FutureOr<void> _todayAttendance(
      TodayAttendance event, Emitter<StudentAttendanceState> emit) async {
    String sId = _localStorageRepo.read(key: loginIdDB)!;
    final queryParams = {
      "date": getDate(value: DateTime.now().toString(), formate: "yyyy-MM-dd")
    };

    final today = await _apiRepo.get<TodayAttendanceStatus>(
        endpoint: buildUrl(todayAttendanceEndPoint(sId: sId), queryParams));

    if (today != null) {
      emit(state.copyWith(todayStatus: today));
    }
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<StudentAttendanceState> emit) {
    add(GetStudentOverView(filterBloc: event.filterBloc));
  }

  FutureOr<void> _getCalanderOverView(
      GetCalanderOverView event, Emitter<StudentAttendanceState> emit) async {
    String lastDate = getDate(
        value: getLastDayOfMonth(event.date).toString(), formate: "yyyy-MM-dd");

    if (state.lastDate != lastDate) {
      emit(state.copyWith(loading: true));
      String sId = _localStorageRepo.read(key: loginIdDB)!;
      final queryParams = {"date": lastDate};

      final data = await _apiRepo.get<CalanderAttendanceOverview>(
          endpoint: buildUrl(
              attendanceCalanderOverViewEndPoint(sId: sId), queryParams));

      Map<String, int> events = {};

      if (data != null) {
        for (int i = 0; i < data.data!.length; i++) {
          String monthAndDate =
              getDate(value: data.data![i].date!, formate: "MM-dd");
          events[monthAndDate] = data.data![i].presentStatus!;
        }

        emit(state.copyWith(
          calenderOverview: data,
          loading: false,
          lastDate: lastDate,
          events: events,
        ));
      }
    }
  }
}
