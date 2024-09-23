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
import 'package:school_of_future/features/domain/entities/classwork_list_response.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'classwork_list_event.dart';
part 'classwork_list_state.dart';

class ClassworkListBloc extends Bloc<ClassworkListEvent, ClassworkListState> {
  ClassworkListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(ClassworkListInitial()) {
    on<DataForTab>(_dataForTab);
    on<IsTeacher>(_isTeacher);
    on<ChangeSearch>(_changeSearch);
    on<GetSearchedClasswork>(_getSearchedClasswork);
    on<PressFilter>(_pressFilter);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteClasswork>(_deleteClasswork);
    on<PageIncrement>(_pageIncrement);

    add(IsTeacher());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isTeacher(
      IsTeacher event, Emitter<ClassworkListState> emit) async {
    final isTeacher =
        await LocalData.isTeacher(localStorageRepo: _localStorageRepo);

    emit(state.copyWith(isTeacher: isTeacher));
  }

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<ClassworkListState> emit) async {
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
      "published_at": filterState.startDate,
      "class_id": filterState.selectedClassId,
      "subject_id": filterState.selectedSubjectId,
      "section_id": filterState.selectSectionId,
    };

    final classwork = await _apiRepo.get<ClassworkList>(
        endpoint: buildUrl(teacherClassworkEndPoint, queryParams));

    if (classwork != null) {
      emit(state.copyWith(classworkList: classwork));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<ClassworkListState> emit) {
    emit(state.copyWith(searchText: event.searchText));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetSearchedClasswork(filterBloc: event.filterBloc));
    });
  }

  FutureOr<void> _getSearchedClasswork(
      GetSearchedClasswork event, Emitter<ClassworkListState> emit) async {
    final filterState = event.filterBloc.state;
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "published_at": filterState.startDate,
      "class_id": filterState.selectedClassId,
      "subject_id": filterState.selectedSubjectId,
      "section_id": filterState.selectSectionId,
    };

    final classwork = await _apiRepo.get<ClassworkList>(
      endpoint: buildUrl(teacherClassworkEndPoint, queryParams),
    );

    if (classwork != null) {
      emit(state.copyWith(classworkList: classwork));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<ClassworkListState> emit) async {
    final filterState = event.filterBloc.state;

    emit(state.copyWith(page: 1, isEndList: false, loading: true));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "published_at": filterState.startDate,
      "class_id": filterState.selectedClassId,
      "subject_id": filterState.selectedSubjectId,
      "section_id": filterState.selectSectionId,
    };

    final flterClasswork = await _apiRepo.get<ClassworkList>(
      endpoint: buildUrl(teacherClassworkEndPoint, queryParams),
    );
    if (flterClasswork != null) {
      emit(state.copyWith(classworkList: flterClasswork));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<ClassworkListState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteClasswork(classworkId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(teacherClassworkCreateSreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteClasswork(
      DeleteClasswork event, Emitter<ClassworkListState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: classworkDetailsEndPoint(
          id: event.classworkId,
        ),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          classworkListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<ClassworkListState> emit) async {
    final filterState = event.filterBloc.state;
    int totalPage = state.page + 1;

    if (totalPage <= state.classworkList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "status": state.activeTab,
          "search": state.searchText,
          "published_at": filterState.startDate,
          "class_id": filterState.selectedClassId,
          "subject_id": filterState.selectedSubjectId,
          "section_id": filterState.selectSectionId,
        };

        final classwork = await _apiRepo.get<ClassworkList>(
          endpoint: buildUrl(teacherClassworkEndPoint, queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (classwork != null) {
          emit(state.copyWith(
              classworkList: ClassworkList(
            data: state.classworkList.data! + classwork.data!,
            lastPage: classwork.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
