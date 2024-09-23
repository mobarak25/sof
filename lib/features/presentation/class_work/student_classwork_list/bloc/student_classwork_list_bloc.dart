import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/debounce.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/classwork_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'student_classwork_list_event.dart';
part 'student_classwork_list_state.dart';

class StudentClassworkListBloc
    extends Bloc<StudentClassworkListEvent, StudentClassworkListState> {
  StudentClassworkListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentClassworkListInitial()) {
    on<DataForTab>(_dataForTab);

    on<ChangeSearch>(_changeSearch);
    on<GetSearchedClasswork>(_getSearchedClasswork);
    on<PressFilter>(_pressFilter);
    on<PageIncrement>(_pageIncrement);

    add(DataForTab(tabIndex: state.activeTab));
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<StudentClassworkListState> emit) async {
    emit(state.copyWith(isFirst: false));

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
      "subject_id": state.subjectId,
      "published_at": state.publishedAt,
    };

    final classwork = await _apiRepo.get<ClassworkList>(
      endpoint: buildUrl(
          studentClassworkEndPoint(
              sId: _localStorageRepo.read(key: loginIdDB)!),
          queryParams),
    );

    if (classwork != null) {
      emit(state.copyWith(classworkList: classwork));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<StudentClassworkListState> emit) {
    emit(state.copyWith(searchText: event.searchText));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetSearchedClasswork());
    });
  }

  FutureOr<void> _getSearchedClasswork(GetSearchedClasswork event,
      Emitter<StudentClassworkListState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "published_at": state.publishedAt,
      "subject_id": state.subjectId,
    };

    final classwork = await _apiRepo.get<ClassworkList>(
      endpoint: buildUrl(
          studentClassworkEndPoint(
              sId: _localStorageRepo.read(key: loginIdDB)!),
          queryParams),
    );

    if (classwork != null) {
      emit(state.copyWith(classworkList: classwork));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<StudentClassworkListState> emit) async {
    emit(state.copyWith(page: 1, isEndList: false, loading: true));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "published_at": state.publishedAt,
      "subject_id": state.subjectId,
    };

    final flterClasswork = await _apiRepo.get<ClassworkList>(
      endpoint: buildUrl(
        studentClassworkEndPoint(sId: _localStorageRepo.read(key: loginIdDB)!),
        queryParams,
      ),
    );
    if (flterClasswork != null) {
      emit(state.copyWith(classworkList: flterClasswork));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<StudentClassworkListState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.classworkList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "status": state.activeTab,
          "search": state.searchText,
          "published_at": state.publishedAt,
          "subject_id": state.subjectId,
        };

        final classwork = await _apiRepo.get<ClassworkList>(
          endpoint: buildUrl(
            studentClassworkEndPoint(
                sId: _localStorageRepo.read(key: loginIdDB)!),
            queryParams,
          ),
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
