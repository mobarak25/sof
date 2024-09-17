import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/debounce.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/confirm_delete_dialog.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
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
    on<SelectSubjectId>(_selectSubjectId);
    on<SelectSectionId>(_selectSectionId);
    on<PressFilter>(_pressFilter);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteAssignment>(_deleteAssignment);
    on<PageIncrement>(_pageIncrement);

    add(DataForTab(tabIndex: state.activeTab.toString()));
    add(GetVersionList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<TeacherAssignmentListState> emit) async {
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
      "start_date": state.startDate,
      "end_date": state.endDate,
      "class_id": state.selectedClassId,
      "subject_id": state.selectedSubjectId,
      "section_id": state.selectSectionId,
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
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "start_date": state.startDate,
      "end_date": state.endDate,
      "class_id": state.selectedClassId,
      "subject_id": state.selectedSubjectId,
      "section_id": state.selectSectionId,
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
    final versionList = await _apiRepo.get<GetBacthAsSections>(
        endpoint: getBatchAsSectionsEndPoint);

    List<DropdownItem> list = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (versionList != null) {
      for (int i = 0; i < versionList.data!.length; i++) {
        list.add(
          DropdownItem(
              name: versionList.data![i].versionName!,
              value: versionList.data![i].versionId),
        );
      }

      emit(state.copyWith(versionList: list, bacthAsSection: versionList));
    }
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<TeacherAssignmentListState> emit) {
    final data = state.bacthAsSection.data!;
    List<DropdownItem> classList = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (event.id != state.selectedVersionId) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].versionId == event.id) {
          for (int j = 0; j < data[i].classes!.length; j++) {
            classList.add(DropdownItem(
                name: data[i].classes![j].className!,
                value: data[i].classes![j].classId!));
          }
        }
      }

      emit(state.copyWith(
        selectedVersionId: event.id,
        setClass: true,
        setSubject: true,
        setSection: true,
        selectedClassId: -1,
        selectedSubjectId: -1,
        selectSectionId: -1,
        classList: classList,
        subjectList: [
          const DropdownItem(name: "Select", value: -1),
        ],
        sectionList: [
          const DropdownItem(name: "Select", value: -1),
        ],
      ));
    }
  }

  FutureOr<void> _selectClassId(
      SelectClassId event, Emitter<TeacherAssignmentListState> emit) {
    final data = state.bacthAsSection.data!;
    List<DropdownItem> subjectList = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (event.id != state.selectedClassId) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].versionId == state.selectedVersionId) {
          for (int j = 0; j < data[i].classes!.length; j++) {
            if (data[i].classes![j].classId == event.id) {
              for (int k = 0; k < data[i].classes![j].subjects!.length; k++) {
                subjectList.add(DropdownItem(
                    name: data[i].classes![j].subjects![k].subjectName!,
                    value: data[i].classes![j].subjects![k].subjectId!));
              }
            }
          }
        }
      }

      emit(state.copyWith(
        selectedClassId: event.id,
        setSubject: true,
        setSection: true,
        selectedSubjectId: -1,
        selectSectionId: -1,
        subjectList: subjectList,
        sectionList: [
          const DropdownItem(name: "Select", value: -1),
        ],
      ));
    }
  }

  FutureOr<void> _selectSubjectId(
      SelectSubjectId event, Emitter<TeacherAssignmentListState> emit) {
    final data = state.bacthAsSection.data!;
    List<DropdownItem> sectionList = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (event.id != state.selectedSubjectId) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].versionId == state.selectedVersionId) {
          for (int j = 0; j < data[i].classes!.length; j++) {
            if (data[i].classes![j].classId == state.selectedClassId) {
              for (int k = 0; k < data[i].classes![j].subjects!.length; k++) {
                if (data[i].classes![j].subjects![k].subjectId == event.id) {
                  final sections = data[i].classes![j].subjects![k].sections!;
                  for (int l = 0; l < sections.length; l++) {
                    sectionList.add(DropdownItem(
                        name: sections[l].sectionName!,
                        value: sections[l].batchId));
                  }
                }
              }
            }
          }
        }
      }
      emit(state.copyWith(
        selectedSubjectId: event.id,
        setSection: true,
        selectSectionId: -1,
        sectionList: sectionList,
      ));
    }
  }

  FutureOr<void> _selectSectionId(
      SelectSectionId event, Emitter<TeacherAssignmentListState> emit) {
    emit(state.copyWith(selectSectionId: event.id));
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<TeacherAssignmentListState> emit) async {
    emit(state.copyWith(page: 1, isEndList: false, loading: true));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "start_date": state.startDate,
      "end_date": state.endDate,
      "class_id": state.selectedClassId,
      "subject_id": state.selectedSubjectId,
      "section_id": state.selectSectionId,
    };

    final flterAssignment = await _apiRepo.get<TeacherAssignment>(
      endpoint: buildUrl(teacherAssignmentEndPoint, queryParams),
    );
    if (flterAssignment != null) {
      emit(state.copyWith(assignmentList: flterAssignment));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<TeacherAssignmentListState> emit) {
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
      DeleteAssignment event, Emitter<TeacherAssignmentListState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: deleteAssignmentEndPoint(
          id: event.assignmentId,
        ),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          teacherAssignmentListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<TeacherAssignmentListState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.assignmentList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "status": state.activeTab,
          "search": state.searchText,
          "start_date": state.startDate,
          "end_date": state.endDate,
          "class_id": state.selectedClassId,
          "subject_id": state.selectedSubjectId,
          "section_id": state.selectSectionId,
        };

        final assignment = await _apiRepo.get<TeacherAssignment>(
          endpoint: buildUrl(teacherAssignmentEndPoint, queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (assignment != null) {
          emit(state.copyWith(
              assignmentList: TeacherAssignment(
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
