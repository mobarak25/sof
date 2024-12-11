import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/widgets/confirm_delete_dialog.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/assignment_list_response.dart';
import 'package:school_of_future/features/domain/entities/dashborard_notice_response.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/due_task_response.dart';
import 'package:school_of_future/features/domain/entities/exam_list_response.dart';
import 'package:school_of_future/features/domain/entities/next_class_response.dart';
import 'package:school_of_future/features/domain/entities/student_profile_response.dart';
import 'package:school_of_future/features/domain/entities/subject_item_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_assignment_response.dart';
import 'package:school_of_future/features/domain/entities/today_activity_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';

part 'student_home_event.dart';
part 'student_home_state.dart';

class StudentHomeBloc extends Bloc<StudentHomeEvent, StudentHomeState> {
  StudentHomeBloc(
      this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(StudentHomeInitial()) {
    on<GetVersion>(_getVersion);
    on<GetUserProfile>(_getUserProfile);
    on<GetNextClass>(_getNextClass);
    on<GetTodayActivity>(_getTodayActivity);
    on<GetSubjectList>(_getSubjectList);
    on<GetDashboardNotice>(_getDashboardNotice);
    on<GetDashboardDueTask>(_getDashboardDueTask);
    on<GetDashboardHomework>(_getDashboardHomework);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteAssignment>(_deleteAssignment);
    on<GetDashboardExam>(_getDashboardExam);

    on<RefreshScreen>(_refreshScreen);

    add(GetVersion());
    add(GetNextClass());
    add(GetTodayActivity());
    add(GetUserProfile());
    add(GetSubjectList());
    add(GetDashboardNotice());
    add(GetDashboardDueTask());
    add(GetDashboardHomework());
    add(GetDashboardExam());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getVersion(
      GetVersion event, Emitter<StudentHomeState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(
        version: packageInfo.version,
        isTeacher:
            await LocalData.isTeacher(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _getNextClass(
      GetNextClass event, Emitter<StudentHomeState> emit) async {
    final type = _localStorageRepo.read(key: userTypeDB);
    final nextClassFromDB =
        await _localStorageRepo.readModel<NextClass>(key: nextClassDB);

    if (nextClassFromDB != null) {
      emit(state.copyWith(nextClass: nextClassFromDB));
    }

    final nextClass = await _apiRepo.get<NextClass>(
        endpoint: type == "2"
            ? teacherNextClassEndPoint
            : nextClassEndPoint(sId: _localStorageRepo.read(key: loginIdDB)!));

    if (nextClass != null) {
      emit(state.copyWith(nextClass: nextClass));

      await _localStorageRepo.writeModel(key: nextClassDB, value: nextClass);
    }
  }

  FutureOr<void> _getTodayActivity(
      GetTodayActivity event, Emitter<StudentHomeState> emit) async {
    final todayActivityFromDB = await _localStorageRepo
        .readModel<TodayActivities>(key: todayActivityDB);

    if (todayActivityFromDB != null) {
      emit(state.copyWith(todayActivity: todayActivityFromDB));
    }

    final todayActivity = await _apiRepo.get<TodayActivities>(
        endpoint: todayActivityEndPoint(
            sId: _localStorageRepo.read(key: loginIdDB)!));

    if (todayActivity != null) {
      emit(state.copyWith(todayActivity: todayActivity));

      await _localStorageRepo.writeModel(
          key: todayActivityDB, value: todayActivity);
    }
  }

  FutureOr<void> _getUserProfile(
      GetUserProfile event, Emitter<StudentHomeState> emit) async {
    emit(state.copyWith(loading: true));
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

    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _getSubjectList(
      GetSubjectList event, Emitter<StudentHomeState> emit) async {
    final subjectFromDB =
        await _localStorageRepo.readModel<SubjectResponse>(key: subjectListDB);

    if (subjectFromDB != null) {
      emit(state.copyWith(subjectList: subjectFromDB));
    }

    final subjects = await _apiRepo.get<SubjectResponse>(
        endpoint: getAllSubjectEndPoint(
            sId: _localStorageRepo.read(key: loginIdDB)!));
    if (subjects != null) {
      emit(state.copyWith(subjectList: subjects));
      await _localStorageRepo.writeModel(key: subjectListDB, value: subjects);
    }
  }

  FutureOr<void> _getDashboardNotice(
      GetDashboardNotice event, Emitter<StudentHomeState> emit) async {
    final type = _localStorageRepo.read(key: userTypeDB);
    final noticeFromDb = await _localStorageRepo.readModel<DashboardNoticeRes>(
        key: dashboardNoticeDb);

    if (noticeFromDb != null) {
      emit(state.copyWith(notice: noticeFromDb));
    }

    final notice = await _apiRepo.get<DashboardNoticeRes>(
        endpoint: type == '2'
            ? teacherNoticeEndPoint
            : studentNoticeEndPoint(
                sId: _localStorageRepo.read(key: loginIdDB)!));
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

  FutureOr<void> _getDashboardHomework(
      GetDashboardHomework event, Emitter<StudentHomeState> emit) async {
    final type = _localStorageRepo.read(key: userTypeDB);

    if (type == '2') {
      final homework = await _apiRepo.get<TeacherAssignment>(
          endpoint: teacherAssignmentEndPoint);

      if (homework != null) {
        emit(state.copyWith(homework: homework));
      }
    } else {
      final studentHomework = await _apiRepo.get<AssignmentResponse>(
        endpoint: studentAssignmentEndPoint(
            sId: _localStorageRepo.read(key: loginIdDB)!),
      );

      if (studentHomework != null) {
        emit(state.copyWith(studentHomework: studentHomework));
      }
    }
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<StudentHomeState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteAssignment(assignmentId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(teacherAssignmentCreateScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteAssignment(
      DeleteAssignment event, Emitter<StudentHomeState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: deleteAssignmentEndPoint(
          id: event.assignmentId,
        ),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
      add(RefreshScreen());
    }
  }

  FutureOr<void> _getDashboardExam(
      GetDashboardExam event, Emitter<StudentHomeState> emit) async {
    final isTeacher =
        await LocalData.isTeacher(localStorageRepo: _localStorageRepo)!;
    String sId = _localStorageRepo.read(key: loginIdDB)!;

    final examList = await _apiRepo.get<ExamList>(
      endpoint: isTeacher
          ? teacherExamListEndPoint
          : studentExamListEndPoint(sId: sId),
    );

    if (examList != null) {
      emit(state.copyWith(examList: examList));
    }
  }

  FutureOr<void> _refreshScreen(
      RefreshScreen event, Emitter<StudentHomeState> emit) {
    add(GetVersion());
    add(GetNextClass());
    add(GetTodayActivity());
    add(GetUserProfile());
    add(GetSubjectList());
    add(GetDashboardNotice());
    add(GetDashboardDueTask());
    add(GetDashboardHomework());
    add(GetDashboardExam());
  }
}



// <List<UserAddress>, UserAddress>