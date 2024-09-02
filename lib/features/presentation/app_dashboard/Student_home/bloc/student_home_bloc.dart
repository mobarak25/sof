import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/due_task_response.dart';
import 'package:school_of_future/features/domain/entities/notice_response.dart';
import 'package:school_of_future/features/domain/entities/student_profile_response.dart';
import 'package:school_of_future/features/domain/entities/subject_item_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'student_home_event.dart';
part 'student_home_state.dart';

class StudentHomeBloc extends Bloc<StudentHomeEvent, StudentHomeState> {
  StudentHomeBloc(
      this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(StudentHomeInitial()) {
    on<GetVersion>(_getVersion);
    on<GetUserProfile>(_getUserProfile);
    on<GetSubjectList>(_getSubjectList);
    on<GetDashboardNotice>(_getDashboardNotice);
    on<GetDashboardDueTask>(_getDashboardDueTask);

    add(GetVersion());
    add(GetUserProfile());
    add(GetSubjectList());
    add(GetDashboardNotice());
    add(GetDashboardDueTask());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getVersion(
      GetVersion event, Emitter<StudentHomeState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(version: packageInfo.version));
  }

  FutureOr<void> _getUserProfile(
      GetUserProfile event, Emitter<StudentHomeState> emit) async {
    final profileFromDB = await _localStorageRepo
        .readModel<StudentProfileResponse>(key: profileDB);

    if (profileFromDB != null) {
      emit(state.copyWith(profile: profileFromDB));
    }

    final profileResponse = await _apiRepo.get<StudentProfileResponse>(
      endpoint:
          studentProfileEndPoint(sId: _localStorageRepo.read(key: loginIdDB)!),
    );

    if (profileResponse != null) {
      emit(state.copyWith(profile: profileResponse));

      await _localStorageRepo.writeModel(
          key: profileDB, value: profileResponse);
    }
  }

  FutureOr<void> _getSubjectList(
      GetSubjectList event, Emitter<StudentHomeState> emit) async {
    final subjectFromDB = await _localStorageRepo
        .readModelForList<List<SubjectItem>, SubjectItem>(key: subjectListDB);

    if (subjectFromDB != null) {
      emit(state.copyWith(subjectList: subjectFromDB));
    }

    final subjects = await _apiRepo.get<SubjectResponse>(
        endpoint: getAllSubjectEndPoint(
            sId: _localStorageRepo.read(key: loginIdDB)!));
    if (subjects != null) {
      emit(state.copyWith(subjectList: subjects.data));
      await _localStorageRepo.writeModel(key: subjectListDB, value: subjects);
    }
  }

  FutureOr<void> _getDashboardNotice(
      GetDashboardNotice event, Emitter<StudentHomeState> emit) async {
    final noticeFromDb = await _localStorageRepo.readModel<NoticeResponse>(
        key: dashboardNoticeDb);

    if (noticeFromDb != null) {
      emit(state.copyWith(notice: noticeFromDb));
    }

    final notice = await _apiRepo.get<NoticeResponse>(endpoint: noticeEndPoint);
    if (notice != null) {
      emit(state.copyWith(notice: notice));
      await _localStorageRepo.writeModel(key: dashboardNoticeDb, value: notice);
    }
  }

  FutureOr<void> _getDashboardDueTask(
      GetDashboardDueTask event, Emitter<StudentHomeState> emit) async {
    final dueTaskfromDB = await _localStorageRepo.readModel<DueTaskResponse>(
        key: dashboardDueTaskDB);

    if (dueTaskfromDB != null) {
      emit(state.copyWith(dueTaskList: dueTaskfromDB));
    }

    final duetask = await _apiRepo.get<DueTaskResponse>(
        endpoint:
            dueTaskEndPoint(sId: _localStorageRepo.read(key: loginIdDB)!));

    if (duetask != null) {
      emit(state.copyWith(dueTaskList: duetask));
      await _localStorageRepo.writeModel(
          key: dashboardDueTaskDB, value: duetask);
    }
  }
}



// <List<UserAddress>, UserAddress>