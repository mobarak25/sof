import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/exam_details_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_exam_create_event.dart';
part 'teacher_exam_create_state.dart';

class TeacherExamCreateBloc
    extends Bloc<TeacherExamCreateEvent, TeacherExamCreateState> {
  TeacherExamCreateBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherExamCreateInitial()) {
    on<GetVersionList>(_getVersionList);
    on<ExamIdForEdit>(_examIdForEdit);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    //on<CheckSubjectId>(_checkSubjectId);
    on<SelectSectionId>(_selectSectionId);
    on<ExamDate>(_examDate);

    on<PressToCreate>(_pressToCreate);
    on<AddData>(_addData);

    add(GetVersionList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<TeacherExamCreateState> emit) async {
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

      if (state.examId != -1) {
        final details = await _apiRepo.get<ExamDetails>(
          endpoint: teacherExamDtlsEndPoint(examId: state.examId),
        );

        if (details != null) {
          emit(state.copyWith(examDtls: details));
          final data = state.examDtls.data!;

          add(SelectVersionId(id: data.batch!.versionId));
          add(SelectClassId(id: data.batch!.classId));
          add(SelectSubjectId(id: data.subjectId));
          add(SelectSectionId(id: data.batchId));

          add(
            AddData(
              examDate: data.date!,
              selectedVersionId: data.batch!.versionId!,
              selectedClassId: data.batch!.classId!,
              selectedSubjectId: data.subjectId,
              selectedSectionId: data.batchId,
            ),
          );
        }
      }
    }
  }

  FutureOr<void> _examIdForEdit(
      ExamIdForEdit event, Emitter<TeacherExamCreateState> emit) {
    emit(state.copyWith(examId: event.examId));
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<TeacherExamCreateState> emit) {
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
        subjectList: [const DropdownItem(name: "Select", value: -1)],
        sectionList: [const DropdownItem(name: "Select", value: -1)],
      ));
    }
  }

  FutureOr<void> _selectClassId(
      SelectClassId event, Emitter<TeacherExamCreateState> emit) {
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
        sectionList: [const DropdownItem(name: "Select", value: -1)],
      ));
    }
  }

  FutureOr<void> _selectSubjectId(
      SelectSubjectId event, Emitter<TeacherExamCreateState> emit) {
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
      SelectSectionId event, Emitter<TeacherExamCreateState> emit) {
    emit(state.copyWith(selectSectionId: event.id));
  }

  FutureOr<void> _examDate(
      ExamDate event, Emitter<TeacherExamCreateState> emit) {
    final date = getDate(value: event.examDate, formate: "yyyy-MM-dd");

    emit(state.copyWith(examDate: date));
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<TeacherExamCreateState> emit) {}

  FutureOr<void> _addData(AddData event, Emitter<TeacherExamCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        examDate: getDate(value: event.examDate, formate: "yyyy-MM-dd"),
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        selectSectionId: event.selectedSectionId,
        isFirstTime: false,
      ));
    }
  }
}
