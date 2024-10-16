import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
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
import 'package:school_of_future/features/domain/entities/student_leave_list_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_own_leave_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_own_leave_event.dart';
part 'teacher_own_leave_state.dart';

class TeacherOwnLeaveBloc
    extends Bloc<TeacherOwnLeaveEvent, TeacherOwnLeaveState> {
  TeacherOwnLeaveBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherOwnLeaveInitial()) {
    on<DataForTab>(_dataForTab);
    on<ChangeSearch>(_changeSearch);
    on<GetSearchedLeave>(_getSearchedLeave);
    on<SelectStartDate>(_selectStartDate);
    on<SelectEndDate>(_selectEndDate);
    on<PressFilter>(_pressFilter);
    on<PageIncrement>(_pageIncrement);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteLeave>(_deleteLeave);

    add(DataForTab(tabIndex: state.activeTab));
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<TeacherOwnLeaveState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));

    if (event.tabIndex == '0') {
      emit(state.copyWith(activeTab: '1', loading: true));
    } else if (event.tabIndex == '1') {
      emit(state.copyWith(activeTab: '2', loading: true));
    } else {
      emit(state.copyWith(activeTab: '3', loading: true));
    }

    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "from_date": state.startDate,
      "to_date": state.endDate,
    };

    final leaves = await _apiRepo.get<TeacherOwnLeaveList>(
      endpoint: buildUrl(teacherOwnLeaveEndPoint, queryParams),
    );

    if (leaves != null) {
      emit(state.copyWith(leaveList: leaves));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<TeacherOwnLeaveState> emit) {
    emit(state.copyWith(searchText: event.searchText));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetSearchedLeave());
    });
  }

  FutureOr<void> _getSearchedLeave(
      GetSearchedLeave event, Emitter<TeacherOwnLeaveState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "from_date": state.startDate,
      "to_date": state.endDate,
    };

    final searchLeave = await _apiRepo.get<TeacherOwnLeaveList>(
      endpoint: buildUrl(teacherOwnLeaveEndPoint, queryParams),
    );

    if (searchLeave != null) {
      emit(state.copyWith(leaveList: searchLeave));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _selectStartDate(
      SelectStartDate event, Emitter<TeacherOwnLeaveState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.startDate);
    event.startController.text =
        DateFormat('dd MMM yyyy').format(event.startDate);

    emit(state.copyWith(startDate: date));
  }

  FutureOr<void> _selectEndDate(
      SelectEndDate event, Emitter<TeacherOwnLeaveState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.endDate);
    event.endController.text = DateFormat('dd MMM yyyy').format(event.endDate);

    emit(state.copyWith(endDate: date));
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<TeacherOwnLeaveState> emit) {
    add(GetSearchedLeave());
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<TeacherOwnLeaveState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteLeave(id: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(teacherOwnApplyLeaveScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteLeave(
      DeleteLeave event, Emitter<TeacherOwnLeaveState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: teacherOwnLeaveDtlsEndPoint(id: event.id),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          teacherOwnleaveListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<TeacherOwnLeaveState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.leaveList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "status": state.activeTab,
          "search": state.searchText,
          "from_date": state.startDate,
          "to_date": state.endDate,
        };

        final pagiLeave = await _apiRepo.get<TeacherOwnLeaveList>(
          endpoint: buildUrl(teacherOwnLeaveEndPoint, queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (pagiLeave != null) {
          emit(state.copyWith(
              leaveList: TeacherOwnLeaveList(
            data: state.leaveList.data! + pagiLeave.data!,
            lastPage: pagiLeave.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
