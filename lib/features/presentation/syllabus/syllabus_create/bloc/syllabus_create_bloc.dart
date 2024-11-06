import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/file_picker/file_picker_service.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/confirm_cancel_dialog.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/syllabus_details_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'syllabus_create_event.dart';
part 'syllabus_create_state.dart';

class SyllabusCreateBloc
    extends Bloc<SyllabusCreateEvent, SyllabusCreateState> {
  SyllabusCreateBloc(this._apiRepo, this._iFlutterNavigator,
      this._localStorageRepo, this._filePickerRepo)
      : super(SyllabusCreateInitial()) {
    on<SyllabusIdForEdit>(_syllabusIdForEdit);
    on<ChangeTitle>(_changeTitle);
    on<ChangeMarks>(_changeMarks);
    on<PublishDate>(_publishDate);
    on<SelectSyllabusType>(_selectSyllabusType);
    on<GetFile>(_getFile);
    on<RemoveFile>(_removeFile);
    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    on<SelectSectionId>(_selectSectionId);
    on<AddData>(_addData);
    on<PressToCreate>(_pressToCreate);
    on<PressToCancel>(_pressToCancel);

    add(GetVersionList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  final FilePickerRepo _filePickerRepo;

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<SyllabusCreateState> emit) async {
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

      if (state.syllabusId != -1) {
        final details = await _apiRepo.get<SyllabusDetails>(
          endpoint: syllabusDetailsEndPoint(syllabusId: state.syllabusId),
        );

        if (details != null) {
          emit(state.copyWith(details: details));

          final data = state.details.data!;

          add(SelectVersionId(id: data.versionId));
          add(SelectClassId(id: data.classId));
          add(SelectSubjectId(id: data.subjectId));
          add(SelectSectionId(id: data.sectionId));

          add(AddData(
            title: data.title!,
            content: data.content,
            date: data.date!,
            marks: data.mark!.toString(),
            syllabusType: data.type,
            selectedVersionId: data.versionId,
            selectedClassId: data.classId,
            selectedSubjectId: data.subjectId,
            selectedSectionId: data.sectionId,
          ));
        }
      }
    }
  }

  FutureOr<void> _syllabusIdForEdit(
      SyllabusIdForEdit event, Emitter<SyllabusCreateState> emit) async {
    emit(state.copyWith(syllabusId: event.syllabusId));
  }

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<SyllabusCreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _changeMarks(
      ChangeMarks event, Emitter<SyllabusCreateState> emit) {
    emit(state.copyWith(marks: event.marks));
  }

  FutureOr<void> _publishDate(
      PublishDate event, Emitter<SyllabusCreateState> emit) {
    final date = getDate(value: event.publishedAt, formate: "yyyy-MM-dd");
    emit(state.copyWith(date: date));
  }

  FutureOr<void> _selectSyllabusType(
      SelectSyllabusType event, Emitter<SyllabusCreateState> emit) {
    emit(state.copyWith(syllabusType: event.type));
  }

  FutureOr<void> _getFile(
      GetFile event, Emitter<SyllabusCreateState> emit) async {
    FilePickerResult? result = await _filePickerRepo.filePicker();

    List<File> tempFileList = [];

    if (result != null) {
      final files = result.paths
          .map((path) => path != null ? File(path) : File(''))
          .toList();
      tempFileList.clear();
      tempFileList.addAll(files);

      files.map((newFile) {
        state.fileList.map((oldFile) {
          if (newFile.path == oldFile.path) {
            tempFileList.remove(newFile);
          }
        });
      });

      emit(state.copyWith(fileList: state.fileList + tempFileList));
    } else {}
  }

  FutureOr<void> _removeFile(
      RemoveFile event, Emitter<SyllabusCreateState> emit) {
    emit(state.copyWith(
        fileList: List.from(state.fileList)..removeAt(event.index)));
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<SyllabusCreateState> emit) {
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
      SelectClassId event, Emitter<SyllabusCreateState> emit) {
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
      SelectSubjectId event, Emitter<SyllabusCreateState> emit) {
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
      SelectSectionId event, Emitter<SyllabusCreateState> emit) {
    emit(state.copyWith(selectSectionId: event.id));
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<SyllabusCreateState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final create = await _apiRepo.appMultipart<DefaultResponse, void>(
        endpoint: state.syllabusId != -1
            ? syllabusDetailsEndPoint(syllabusId: state.syllabusId)
            : teacherSyllabusListEndPoint,
        body: {
          "status": event.isDraft ? 0 : 1,
          "title": state.title,
          "date": state.date,
          "mark": state.marks,
          "content": event.content,
          "type": state.syllabusType,
          "version_id": state.selectedVersionId,
          "class_id": state.selectedClassId,
          "subject_id": state.selectedSubjectId,
          "section_id": state.selectSectionId,
          "_method": state.syllabusId == -1 ? "POST" : "PUT",
        },
        fileFieldName: "syllabus_attachment__url",
        files: state.fileList,
      );

      if (create != null) {
        Navigator.popUntil(
            _iFlutterNavigator.context, (route) => route.isFirst);
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            teacherSyllabusListScreen, ModalRoute.withName('/'));
        ShowSnackBar(message: create.message!, navigator: _iFlutterNavigator);
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(PressToCreate event) {
    final validate = Validator.isValidated(items: [
      FormItem(text: state.title, focusNode: event.titleFocusnode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.title.isEmpty ||
        state.date.isEmpty ||
        state.syllabusType == -1 ||
        state.selectedVersionId == -1 ||
        state.selectedClassId == -1 ||
        state.selectedSubjectId == -1 ||
        state.selectSectionId == -1) {
      return false;
    }
    return true;
  }

  FutureOr<void> _addData(AddData event, Emitter<SyllabusCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        title: event.title,
        content: event.content,
        date: getDate(value: event.date, formate: "yyyy-MM-dd"),
        marks: event.marks,
        syllabusType: event.syllabusType,
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        isFirstTime: false,
      ));
    }
  }

  FutureOr<void> _pressToCancel(
      PressToCancel event, Emitter<SyllabusCreateState> emit) {
    showCancelDialog(_iFlutterNavigator.context, pressToYes: () {
      // _iFlutterNavigator.pop();
      // navigatorKey.currentState!.pushNamedAndRemoveUntil(
      //     classworkListScreen, ModalRoute.withName('/'));
      Navigator.popUntil(_iFlutterNavigator.context, (route) => route.isFirst);
    });
  }
}
