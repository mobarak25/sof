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
import 'package:school_of_future/features/domain/entities/assignment_list_response.dart';
import 'package:school_of_future/features/domain/entities/subject_item_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'student_assignment_list_event.dart';
part 'student_assignment_list_state.dart';

class StudentAssignmentListBloc
    extends Bloc<StudentAssignmentListEvent, StudentAssignmentListState> {
  StudentAssignmentListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentAssignmentListInitial()) {
    on<DataForTab>(_dataForTab);
    on<ChangeSearch>(_changeSearch);
    on<GetSearchedAssignment>(_getSearchedAssignment);
    on<SelectStartDate>(_selectStartDate);
    on<SelectEndDate>(_selectEndDate);
    on<GetSubjectList>(_getSubjectList);
    on<SelectSubjectId>(_selectSubjectId);
    on<PressFilter>(_pressFilter);
    on<PageIncrement>(_pageIncrement);

    add(DataForTab(tabIndex: state.activeTab.toString()));
    add(GetSubjectList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<StudentAssignmentListState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));

    if (event.tabIndex == '0') {
      emit(state.copyWith(activeTab: '', loading: true));
    } else if (event.tabIndex == '1') {
      emit(state.copyWith(activeTab: '0', loading: true));
    } else if (event.tabIndex == '2') {
      emit(state.copyWith(activeTab: '13', loading: true));
    }

    final queryParams = {
      "page": state.page,
      "submission_status": state.activeTab,
      "search": state.searchText,
      "start_date": state.startDate,
      "end_date": state.endDate,
      "subject_id": state.subjectId,
    };

    final assignment = await _apiRepo.get<AssignmentResponse>(
      endpoint: buildUrl(
          studentAssignmentEndPoint(
              sId: _localStorageRepo.read(key: loginIdDB)!),
          queryParams),
    );

    if (assignment != null) {
      emit(state.copyWith(assignmentList: assignment));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<StudentAssignmentListState> emit) {
    emit(state.copyWith(searchText: event.searchText));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetSearchedAssignment());
    });
  }

  FutureOr<void> _getSearchedAssignment(GetSearchedAssignment event,
      Emitter<StudentAssignmentListState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "submission_status": state.activeTab,
      "search": state.searchText,
      "start_date": state.startDate,
      "end_date": state.endDate,
      "subject_id": state.subjectId,
    };

    final searchAssignment = await _apiRepo.get<AssignmentResponse>(
      endpoint: buildUrl(
          studentAssignmentEndPoint(
              sId: _localStorageRepo.read(key: loginIdDB)!),
          queryParams),
    );
    if (searchAssignment != null) {
      emit(state.copyWith(assignmentList: searchAssignment));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _selectStartDate(
      SelectStartDate event, Emitter<StudentAssignmentListState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.startDate);
    event.startController.text =
        DateFormat('dd MMM yyyy').format(event.startDate);

    emit(state.copyWith(startDate: date));
  }

  FutureOr<void> _selectEndDate(
      SelectEndDate event, Emitter<StudentAssignmentListState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.endDate);
    event.endDateController.text =
        DateFormat('dd MMM yyyy').format(event.endDate);

    emit(state.copyWith(endDate: date));
  }

  FutureOr<void> _getSubjectList(
      GetSubjectList event, Emitter<StudentAssignmentListState> emit) async {
    final subjects = await _apiRepo.get<SubjectResponse>(
        endpoint: getAllSubjectEndPoint(
            sId: _localStorageRepo.read(key: loginIdDB)!));

    List<DropdownItem> list = [
      const DropdownItem(name: "Select Subject", value: -1),
    ];
    if (subjects != null) {
      for (int i = 0; i < subjects.data!.length; i++) {
        list.add(DropdownItem(
            name: subjects.data![i].name!, value: subjects.data![i].id));
      }
      emit(state.copyWith(subjectList: list));
      await _localStorageRepo.writeModel(key: subjectListDB, value: subjects);
    }
  }

  FutureOr<void> _selectSubjectId(
      SelectSubjectId event, Emitter<StudentAssignmentListState> emit) {
    emit(state.copyWith(selectedSubId: event.id));
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<StudentAssignmentListState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "submission_status": state.activeTab,
      "search": state.searchText,
      "start_date": state.startDate,
      "end_date": state.endDate,
      "subject_id": state.subjectId,
    };

    final flterAssignment = await _apiRepo.get<AssignmentResponse>(
      endpoint: buildUrl(
          studentAssignmentEndPoint(
              sId: _localStorageRepo.read(key: loginIdDB)!),
          queryParams),
    );
    if (flterAssignment != null) {
      emit(state.copyWith(assignmentList: flterAssignment));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<StudentAssignmentListState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.assignmentList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "submission_status": state.activeTab,
          "search": state.searchText,
          "start_date": state.startDate,
          "end_date": state.endDate,
          "subject_id": state.subjectId,
        };

        final assignment = await _apiRepo.get<AssignmentResponse>(
          endpoint: buildUrl(
              studentAssignmentEndPoint(
                  sId: _localStorageRepo.read(key: loginIdDB)!),
              queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (assignment != null) {
          emit(state.copyWith(
              assignmentList: AssignmentResponse(
            data: state.assignmentList.data! + assignment.data!,
            lastPage: assignment.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
