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
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/resources_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'teacher_resource_list_event.dart';
part 'teacher_resource_list_state.dart';

class TeacherResourceListBloc
    extends Bloc<TeacherResourceListEvent, TeacherResourceListState> {
  TeacherResourceListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherResourceListInitial()) {
    on<DataForTab>(_dataForTab);
    on<ChangeSearch>(_changeSearch);
    on<GetSearchedResources>(_getSearchedResources);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteResource>(_deleteResource);
    on<PressFilter>(_pressFilter);
    on<PageIncrement>(_pageIncrement);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<TeacherResourceListState> emit) async {
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
      "version_id": state.searchText,
      "class_id": filterState.selectedClassId,
      "subject_id": filterState.selectedSubjectId,
      "chapter_id": filterState.selectSectionId,
    };

    final resources = await _apiRepo.get<Resources>(
        endpoint: buildUrl(teacherResourcesListEndPoint, queryParams));

    if (resources != null) {
      emit(state.copyWith(resources: resources));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<TeacherResourceListState> emit) {
    emit(state.copyWith(searchText: event.searchText));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetSearchedResources(filterBloc: event.filterBloc));
    });
  }

  FutureOr<void> _getSearchedResources(GetSearchedResources event,
      Emitter<TeacherResourceListState> emit) async {
    final filterState = event.filterBloc.state;
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "version_id": filterState.selectedVersionId,
      "class_id": filterState.selectedClassId,
      "subject_id": filterState.selectedSubjectId,
      "chapter_id": filterState.selectChapterId,
    };

    final resources = await _apiRepo.get<Resources>(
      endpoint: buildUrl(teacherResourcesListEndPoint, queryParams),
    );

    if (resources != null) {
      emit(state.copyWith(resources: resources));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<TeacherResourceListState> emit) async {
    final filterState = event.filterBloc.state;

    emit(state.copyWith(page: 1, isEndList: false, loading: true));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "version_id": filterState.selectedVersionId,
      "class_id": filterState.selectedClassId,
      "subject_id": filterState.selectedSubjectId,
      "chapter_id": filterState.selectChapterId,
    };

    final flterResources = await _apiRepo.get<Resources>(
      endpoint: buildUrl(teacherResourcesListEndPoint, queryParams),
    );
    if (flterResources != null) {
      emit(state.copyWith(resources: flterResources));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<TeacherResourceListState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteResource(resourceId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(teacherResourcesCreateScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteResource(
      DeleteResource event, Emitter<TeacherResourceListState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: teacherResourcedetailsEndPoint(
          resourceId: event.resourceId,
        ),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          teacherResourcesListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<TeacherResourceListState> emit) async {
    final filterState = event.filterBloc.state;
    int totalPage = state.page + 1;

    if (totalPage <= state.resources.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "status": state.activeTab,
          "search": state.searchText,
          "version_id": filterState.selectedVersionId,
          "class_id": filterState.selectedClassId,
          "subject_id": filterState.selectedSubjectId,
          "chapter_id": filterState.selectChapterId,
        };

        final pagiResources = await _apiRepo.get<Resources>(
          endpoint: buildUrl(teacherResourcesListEndPoint, queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (pagiResources != null) {
          emit(state.copyWith(
              resources: Resources(
            data: state.resources.data! + pagiResources.data!,
            lastPage: pagiResources.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
