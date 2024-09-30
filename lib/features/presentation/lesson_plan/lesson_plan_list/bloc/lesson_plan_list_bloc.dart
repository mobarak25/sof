import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/debounce.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/confirm_delete_dialog.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/lesson_plan_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'lesson_plan_list_event.dart';
part 'lesson_plan_list_state.dart';

class LessonPlanListBloc
    extends Bloc<LessonPlanListEvent, LessonPlanListState> {
  LessonPlanListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(LessonPlanListInitial()) {
    on<IsTeacher>(_isTeacher);
    on<DataForTab>(_dataForTab);
    on<ChangeSearch>(_changeSearch);
    on<GetSearchedLessonPlan>(_getSearchedLessonPlan);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteLessonPlan>(_deleteLessonPlan);
    on<PressFilter>(_pressFilter);
    on<PageIncrement>(_pageIncrement);

    add(IsTeacher());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isTeacher(
      IsTeacher event, Emitter<LessonPlanListState> emit) async {
    emit(state.copyWith(
        isTeacher:
            await LocalData.isTeacher(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<LessonPlanListState> emit) async {
    emit(state.copyWith(isFirst: false));
    final filterState = event.filterBloc.state;
    emit(state.copyWith(page: 1, loading: true, isEndList: false));

    if (event.tabIndex == '0') {
      emit(state.copyWith(activeTab: '1', loading: true));
    } else if (event.tabIndex == '1') {
      emit(state.copyWith(activeTab: '0', loading: true));
    }

    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "version_id": filterState.selectedVersionId,
      "class_id": filterState.selectedClassId,
      "subject_id": filterState.selectedSubjectId,
      "section_id": filterState.selectSectionId,
    };

    final lessonPlan = await _apiRepo.get<LessonPlan>(
      endpoint: getUrlStudentTeacher(queryParams),
    );

    if (lessonPlan != null) {
      emit(state.copyWith(lessonPlanList: lessonPlan));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<LessonPlanListState> emit) {
    emit(state.copyWith(searchText: event.searchText));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetSearchedLessonPlan(filterBloc: event.filterBloc));
    });
  }

  FutureOr<void> _getSearchedLessonPlan(
      GetSearchedLessonPlan event, Emitter<LessonPlanListState> emit) async {
    final filterState = event.filterBloc.state;
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "version_id": filterState.selectedVersionId,
      "class_id": filterState.selectedClassId,
      "subject_id": filterState.selectedSubjectId,
      "section_id": filterState.selectSectionId,
    };

    final planList = await _apiRepo.get<LessonPlan>(
      endpoint: getUrlStudentTeacher(queryParams),
    );

    if (planList != null) {
      emit(state.copyWith(lessonPlanList: planList));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<LessonPlanListState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteLessonPlan(planId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(teacherlessonPlanCreateScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteLessonPlan(
      DeleteLessonPlan event, Emitter<LessonPlanListState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: teacherLessonPlanDetailsEndPoint(
          planId: event.planId,
        ),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          lessonPlanListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<LessonPlanListState> emit) async {
    final filterState = event.filterBloc.state;

    emit(state.copyWith(page: 1, isEndList: false, loading: true));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "version_id": filterState.selectedVersionId,
      "class_id": filterState.selectedClassId,
      "subject_id": state.isTeacher
          ? filterState.selectedSubjectId
          : filterState.selectSubjectIdForStudent,
      "section_id": filterState.selectSectionId,
    };

    final flterPlan = await _apiRepo.get<LessonPlan>(
      endpoint: getUrlStudentTeacher(queryParams),
    );
    if (flterPlan != null) {
      emit(state.copyWith(lessonPlanList: flterPlan));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<LessonPlanListState> emit) {}

  String getUrlStudentTeacher(Map<String, dynamic> queryParams) {
    if (state.isTeacher) {
      return buildUrl(teacherlessonPlanListEndPoint, queryParams);
    } else {
      return buildUrl(
          studentlessonPlanListEndPoint(
              sId: _localStorageRepo.read(key: loginIdDB)!),
          queryParams);
    }
  }
}
