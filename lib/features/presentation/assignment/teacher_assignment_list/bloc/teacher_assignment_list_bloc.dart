import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/debounce.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/subject_item_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_assignment_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_assignment_list_event.dart';
part 'teacher_assignment_list_state.dart';

class TeacherAssignmentListBloc
    extends Bloc<TeacherAssignmentListEvent, TeacherAssignmentListState> {
  TeacherAssignmentListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherAssignmentListInitial()) {
    on<DataForTab>(_dataForTab);
    on<ChangeSearch>(_changeSearch);
    on<GetSearchedAssignment>(_getSearchedAssignment);
    on<SelectStartDate>(_selectStartDate);
    on<SelectEndDate>(_selectEndDate);
    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<PressFilter>(_pressFilter);

    add(DataForTab(tabIndex: state.activeTab.toString()));
    add(GetVersionList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<TeacherAssignmentListState> emit) async {
    emit(state.copyWith(loading: true));

    if (event.tabIndex == '0') {
      emit(state.copyWith(activeTab: '1', loading: true));
    } else if (event.tabIndex == '1') {
      emit(state.copyWith(activeTab: '0', loading: true));
    }

    final queryParams = {
      "status": state.activeTab,
      "search": state.searchText,
      "start_date": state.startDate,
      "end_date": state.endDate,
      "subject_id": state.subjectId,
    };

    final assignment = await _apiRepo.get<TeacherAssignment>(
      endpoint: buildUrl(teacherAssignmentEndPoint, queryParams),
    );

    if (assignment != null) {
      emit(state.copyWith(assignmentList: assignment));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<TeacherAssignmentListState> emit) {
    emit(state.copyWith(searchText: event.searchText));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetSearchedAssignment());
    });
  }

  FutureOr<void> _getSearchedAssignment(GetSearchedAssignment event,
      Emitter<TeacherAssignmentListState> emit) async {
    emit(state.copyWith(page: 1, loading: true));
    final queryParams = {
      "status": state.activeTab,
      "search": state.searchText,
      "start_date": state.startDate,
      "end_date": state.endDate,
      "subject_id": state.subjectId,
    };

    final searchAssignment = await _apiRepo.get<TeacherAssignment>(
      endpoint: buildUrl(teacherAssignmentEndPoint, queryParams),
    );

    if (searchAssignment != null) {
      emit(state.copyWith(assignmentList: searchAssignment));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _selectStartDate(
      SelectStartDate event, Emitter<TeacherAssignmentListState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.startDate);
    event.startController.text =
        DateFormat('dd MMM yyyy').format(event.startDate);

    emit(state.copyWith(startDate: date));
  }

  FutureOr<void> _selectEndDate(
      SelectEndDate event, Emitter<TeacherAssignmentListState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.endDate);
    event.endDateController.text =
        DateFormat('dd MMM yyyy').format(event.endDate);

    emit(state.copyWith(endDate: date));
  }

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<TeacherAssignmentListState> emit) async {
    List<DropdownItem> list = [
      const DropdownItem(name: "Select Subject", value: -1),
      const DropdownItem(name: "Bangla", value: 1),
      const DropdownItem(name: "English", value: 2),
    ];

    emit(state.copyWith(versionList: list));
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<TeacherAssignmentListState> emit) {
    //emit(state.copyWith(selectedVersionId: event.id));

    if (event.id != state.selectedVersionId) {
      emit(state.copyWith(
        selectedVersionId: event.id,
        setClass: true,
        selectedClassId: -1,
      ));
      if (state.selectedVersionId == 1) {
        //add(GetUpazilas());

        emit(state.copyWith(classList: [
          const DropdownItem(name: "Select", value: -1),
          const DropdownItem(name: "Class1", value: 1),
          const DropdownItem(name: "Class2", value: 2),
        ]));
      } else if (state.selectedVersionId == 2) {
        emit(state.copyWith(classList: [
          const DropdownItem(name: "Select", value: -1),
          const DropdownItem(name: "Class3", value: 3),
          const DropdownItem(name: "Class4", value: 4),
        ]));
      }
    }
  }

  FutureOr<void> _selectClassId(
      SelectClassId event, Emitter<TeacherAssignmentListState> emit) {
    emit(state.copyWith(selectedClassId: event.id));
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<TeacherAssignmentListState> emit) async {
    emit(state.copyWith(page: 1, loading: true));
    final queryParams = {
      "status": state.activeTab,
      "search": state.searchText,
      "start_date": state.startDate,
      "end_date": state.endDate,
      "subject_id": state.subjectId,
    };

    final flterAssignment = await _apiRepo.get<TeacherAssignment>(
      endpoint: buildUrl(teacherAssignmentEndPoint, queryParams),
    );
    if (flterAssignment != null) {
      emit(state.copyWith(assignmentList: flterAssignment));
    }
    emit(state.copyWith(loading: false));
  }
}
