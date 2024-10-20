import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/chapter_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/entities/subject_item_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';

part 'filter_sidebar_event.dart';
part 'filter_sidebar_state.dart';

class FilterSidebarBloc extends Bloc<FilterSidebarEvent, FilterSidebarState> {
  FilterSidebarBloc(this._apiRepo, this._localStorageRepo)
      : super(FilterSidebarInitial()) {
    on<IsTeacher>(_isTeacher);
    on<SelectStartDate>(_selectStartDate);
    on<SelectEndDate>(_selectEndDate);
    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    on<SelectSectionId>(_selectSectionId);
    on<SelectChapterId>(_selectChapterId);
    on<SelectSubjectIdForStudent>(_selectSubjectIdForStudent);
    on<GetChapter>(_getChapter);
    on<GetSubjectForStudent>(_getSubjectForStudent);
    on<CheckValidation>(_checkValidation);

    add(IsTeacher());
    add(GetSubjectForStudent());
  }

  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;
  FutureOr<void> _isTeacher(
      IsTeacher event, Emitter<FilterSidebarState> emit) async {
    emit(state.copyWith(
        isTeacher:
            await LocalData.isTeacher(localStorageRepo: _localStorageRepo)));

    if (state.isTeacher) {
      add(GetVersionList());
    }
  }

  FutureOr<void> _selectStartDate(
      SelectStartDate event, Emitter<FilterSidebarState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.startDate);
    event.startController.text =
        DateFormat('dd MMM yyyy').format(event.startDate);

    emit(state.copyWith(startDate: date));
  }

  FutureOr<void> _selectEndDate(
      SelectEndDate event, Emitter<FilterSidebarState> emit) {
    final String date = DateFormat('yyyy-MM-dd').format(event.endDate);
    event.endDateController.text =
        DateFormat('dd MMM yyyy').format(event.endDate);

    emit(state.copyWith(endDate: date));
  }

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<FilterSidebarState> emit) async {
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
      SelectVersionId event, Emitter<FilterSidebarState> emit) {
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
        setChapter: true,
        selectedClassId: -1,
        selectedSubjectId: -1,
        selectSectionId: -1,
        selectChapterId: -1,
        classList: classList,
        subjectList: [const DropdownItem(name: "Select", value: -1)],
        sectionList: [const DropdownItem(name: "Select", value: -1)],
        chapterList: [const DropdownItem(name: "Select", value: -1)],
      ));
    }
  }

  FutureOr<void> _selectClassId(
      SelectClassId event, Emitter<FilterSidebarState> emit) {
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
        setChapter: true,
        selectedSubjectId: -1,
        selectSectionId: -1,
        selectChapterId: -1,
        subjectList: subjectList,
        sectionList: [const DropdownItem(name: "Select", value: -1)],
        chapterList: [const DropdownItem(name: "Select", value: -1)],
      ));
    }
  }

  FutureOr<void> _selectSubjectId(
      SelectSubjectId event, Emitter<FilterSidebarState> emit) {
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
        setChapter: true,
        selectChapterId: -1,
        selectSectionId: -1,
        sectionList: sectionList,
        chapterList: [const DropdownItem(name: "Select", value: -1)],
      ));
    }

    add(GetChapter(subjectId: event.id));
  }

  FutureOr<void> _selectSectionId(
      SelectSectionId event, Emitter<FilterSidebarState> emit) {
    emit(state.copyWith(selectSectionId: event.id));
  }

  FutureOr<void> _selectChapterId(
      SelectChapterId event, Emitter<FilterSidebarState> emit) {
    emit(state.copyWith(selectChapterId: event.id));
  }

  FutureOr<void> _getChapter(
      GetChapter event, Emitter<FilterSidebarState> emit) async {
    final chapter = await _apiRepo.get<Chapter>(
        endpoint: getChapterEndPoint(subjectId: event.subjectId));

    List<DropdownItem> listOfChapter = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (chapter != null) {
      for (int i = 0; i < chapter.data!.length; i++) {
        listOfChapter.add(DropdownItem(
            name: chapter.data![i].name!, value: chapter.data![i].id));
      }
    }
    emit(state.copyWith(chapterList: listOfChapter));
  }

  FutureOr<void> _getSubjectForStudent(
      GetSubjectForStudent event, Emitter<FilterSidebarState> emit) async {
    List<DropdownItem> list = [
      const DropdownItem(name: "Select Subject", value: -1),
    ];

    final subjectFromDB =
        await _localStorageRepo.readModel<SubjectResponse>(key: subjectListDB);

    if (subjectFromDB != null) {
      for (int i = 0; i < subjectFromDB.data!.length; i++) {
        list.add(DropdownItem(
            name: subjectFromDB.data![i].name!,
            value: subjectFromDB.data![i].id));
      }
      emit(state.copyWith(studentSubjectList: list));
      list = [
        const DropdownItem(name: "Select Subject", value: -1),
      ];
    }

    final subjects = await _apiRepo.get<SubjectResponse>(
        endpoint: getAllSubjectEndPoint(
            sId: _localStorageRepo.read(key: loginIdDB)!));

    if (subjects != null) {
      for (int i = 0; i < subjects.data!.length; i++) {
        list.add(DropdownItem(
            name: subjects.data![i].name!, value: subjects.data![i].id));
      }
      emit(state.copyWith(studentSubjectList: list));
      await _localStorageRepo.writeModel(key: subjectListDB, value: subjects);
      list = [
        const DropdownItem(name: "Select Subject", value: -1),
      ];
    }
  }

  FutureOr<void> _selectSubjectIdForStudent(
      SelectSubjectIdForStudent event, Emitter<FilterSidebarState> emit) {
    emit(state.copyWith(
      selectSubjectIdForStudent: event.id,
      setChapter: true,
      selectChapterId: -1,
      chapterList: [const DropdownItem(name: "Select", value: -1)],
    ));
    add(GetChapter(subjectId: event.id));
  }

  FutureOr<void> _checkValidation(
      CheckValidation event, Emitter<FilterSidebarState> emit) {
    if (isValid(event)) {
      emit(state.copyWith(isValid: true));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(CheckValidation event) {
    // final validate = Validator.isValidated(items: [
    //   FormItem(text: state.title, focusNode: event.titleFocusnode),
    // ], navigator: _iFlutterNavigator);

    // if (!validate) return false;

    if (state.selectedVersionId == -1 ||
        state.selectedClassId == -1 ||
        state.selectedSubjectId == -1 ||
        state.selectedVersionId == -1) {
      return false;
    }
    return true;
  }
}
