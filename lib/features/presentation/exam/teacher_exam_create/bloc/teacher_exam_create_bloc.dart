import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/data/model/create_exam.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/exam_details_response.dart';
import 'package:school_of_future/features/domain/entities/exam_group_response.dart';
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
    on<ExamDate>(_examDate);
    on<StartTime>(_startTime);
    on<EndTime>(_endTime);
    on<GetVersionList>(_getVersionList);
    on<ExamIdForEdit>(_examIdForEdit);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    on<SelectSectionId>(_selectSectionId);
    on<SelectGroupId>(_selectGroupId);
    on<SelectTermId>(_selectTermId);
    on<ChangeMaxMark>(_changeMaxMark);
    on<ChangePassMark>(_changePassMark);
    on<ChangeConvertMark>(_changeConvertMark);
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
          final data = details.data!;
          emit(state.copyWith(examDtls: details));

          add(SelectVersionId(id: data.batch!.versionId!));
          add(SelectClassId(id: data.batch!.classId));
          add(SelectSubjectId(id: data.subjectId));
          add(SelectSectionId(id: data.batchId));

          add(
            AddData(
              examDate: data.date!,
              startTime: data.startTime!,
              endTime: data.endTime!,
              maxMark: data.maxMark.toString(),
              convertMark: data.convertMark.toString(),
              passMark: data.passMark.toString(),
              selectedVersionId: data.batch!.versionId!,
              selectedClassId: data.batch!.classId!,
              selectedSubjectId: data.subjectId,
              selectedSectionId: data.batchId,
              selectedExamGroupId: data.examGroupId,
              selectTermId: data.termId,
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
        setGroup: true,
        setTerm: true,
        selectedClassId: -1,
        selectedSubjectId: -1,
        selectSectionId: -1,
        selectedExamGorupId: -1,
        selectTermId: -1,
        classList: classList,
        subjectList: [const DropdownItem(name: "Select", value: -1)],
        sectionList: [const DropdownItem(name: "Select", value: -1)],
        groupList: [const DropdownItem(name: "Select", value: -1)],
        termList: [const DropdownItem(name: "Select", value: -1)],
      ));
    }
  }

  FutureOr<void> _selectClassId(
      SelectClassId event, Emitter<TeacherExamCreateState> emit) async {
    final data = state.bacthAsSection.data!;
    List<DropdownItem> subjectList = [
      const DropdownItem(name: "Select", value: -1),
    ];
    List<DropdownItem> groupList = [
      const DropdownItem(name: "Select", value: -1),
    ];
    List<DropdownItem> termList = [
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
        setGroup: true,
        setTerm: true,
        selectedSubjectId: -1,
        selectSectionId: -1,
        selectedExamGorupId: -1,
        selectTermId: -1,
        subjectList: subjectList,
        groupList: groupList,
        termList: termList,
        sectionList: [const DropdownItem(name: "Select", value: -1)],
      ));

      final queryParams = {
        "version_id": state.selectedVersionId,
        "class_id": state.selectedClassId,
      };

      emit(state.copyWith(loading: true));

      final examGroup = await _apiRepo.get<ExamGroupAntTermList>(
          endpoint: buildUrl(examGroupEndPoint, queryParams));

      if (examGroup != null) {
        for (int i = 0; i < examGroup.data!.length; i++) {
          groupList.add(DropdownItem(
              name: examGroup.data![i].name!, value: examGroup.data![i].id!));
        }
      }

      final examTerm = await _apiRepo.get<ExamGroupAntTermList>(
          endpoint: buildUrl(examTermEndPoint, queryParams));

      if (examTerm != null) {
        for (int i = 0; i < examTerm.data!.length; i++) {
          termList.add(DropdownItem(
              name: examTerm.data![i].name!, value: examTerm.data![i].id!));
        }
      }

      emit(state.copyWith(
        groupList: groupList,
        termList: termList,
        loading: false,
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

  FutureOr<void> _selectGroupId(
      SelectGroupId event, Emitter<TeacherExamCreateState> emit) {
    emit(state.copyWith(selectedExamGorupId: event.id));
  }

  FutureOr<void> _selectTermId(
      SelectTermId event, Emitter<TeacherExamCreateState> emit) {
    emit(state.copyWith(selectTermId: event.id));
  }

  FutureOr<void> _examDate(
      ExamDate event, Emitter<TeacherExamCreateState> emit) {
    final date = getDate(value: event.examDate, formate: "yyyy-MM-dd");

    emit(state.copyWith(examDate: date));
  }

  FutureOr<void> _startTime(
      StartTime event, Emitter<TeacherExamCreateState> emit) {
    emit(state.copyWith(startTime: event.startTime));
  }

  FutureOr<void> _endTime(EndTime event, Emitter<TeacherExamCreateState> emit) {
    emit(state.copyWith(endTime: event.endTime));
  }

  FutureOr<void> _changeMaxMark(
      ChangeMaxMark event, Emitter<TeacherExamCreateState> emit) {
    emit(state.copyWith(maxMark: event.maxMark));
  }

  FutureOr<void> _changeConvertMark(
      ChangeConvertMark event, Emitter<TeacherExamCreateState> emit) {
    emit(state.copyWith(convertMark: event.convertMark));
  }

  FutureOr<void> _changePassMark(
      ChangePassMark event, Emitter<TeacherExamCreateState> emit) {
    emit(state.copyWith(passMark: event.passMark));
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<TeacherExamCreateState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final save = await _apiRepo.post<DefaultResponse>(
        endpoint: teacherExamListEndPoint,
        body: CerateExam(
          date: state.examDate,
          subjectId: state.selectedSubjectId,
          batchId: state.selectSectionId,
          examGroupId: state.selectedExamGorupId,
          termId: state.selectTermId,
          maxMark: state.maxMark,
          convertMark: state.convertMark,
          passMark: state.passMark,
          startTime: state.startTime,
          endTime: state.endTime,
          isPublished: 1,
        ),
      );

      if (save != null) {
        _iFlutterNavigator.pop();
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            teacherExamListScreen, ModalRoute.withName('/'));
        ShowSnackBar(message: save.message!, navigator: _iFlutterNavigator);
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(PressToCreate event) {
    final validate = Validator.isValidated(items: [
      FormItem(text: state.examDate, focusNode: event.examDateFocusnode),
      FormItem(text: state.startTime, focusNode: event.startTimeFocusnode),
      FormItem(text: state.endTime, focusNode: event.endTimeFocusnode),
      FormItem(text: state.maxMark, focusNode: event.maxMarkFocusnode),
      FormItem(text: state.convertMark, focusNode: event.convertMarkFocusnode),
      FormItem(text: state.passMark, focusNode: event.passMarkFocusnode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.examDate.isEmpty ||
        state.startTime.isEmpty ||
        state.endTime.isEmpty ||
        state.maxMark.isEmpty ||
        state.convertMark.isEmpty ||
        state.passMark.isEmpty) {
      return false;
    }
    return true;
  }

  FutureOr<void> _addData(AddData event, Emitter<TeacherExamCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        examDate: getDate(value: event.examDate, formate: "yyyy-MM-dd"),
        startTime: event.startTime,
        endTime: event.endTime,
        maxMark: event.maxMark,
        convertMark: event.convertMark,
        passMark: event.passMark,
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        selectSectionId: event.selectedSectionId,
        selectedExamGorupId: event.selectedExamGroupId,
        selectTermId: event.selectTermId,
        isFirstTime: false,
      ));
    }
  }
}
