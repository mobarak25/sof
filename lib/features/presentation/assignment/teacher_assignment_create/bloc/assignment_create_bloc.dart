import 'dart:async';
import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
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
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/assignment_details_response.dart';
import 'package:school_of_future/features/domain/entities/batch_wise_student.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'assignment_create_event.dart';
part 'assignment_create_state.dart';

class AssignmentCreateBloc
    extends Bloc<AssignmentCreateEvent, AssignmentCreateState> {
  AssignmentCreateBloc(this._apiRepo, this._iFlutterNavigator,
      this._localStorageRepo, this._filePickerRepo)
      : super(AssignmentCreateInitial()) {
    on<AssignmentIdForEdit>(_assignmentIdForEdit);
    on<ChangeTitle>(_changeTitle);
    on<GetFile>(_getFile);
    on<RemoveFile>(_removeFile);
    on<Submitable>(_submitable);
    on<Assessment>(_assessment);
    on<ChangeMark>(_changeMark);
    on<StartDate>(_startDate);
    on<EndDate>(_endDate);
    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    // on<SelectSectionId>(_selectSectionId);
    on<SelectSectionList>(_selectSectionList);
    on<BackWithUnselected>(_backWithUnselected);
    on<PressToCreate>(_pressToCreate);
    on<PressToCancel>(_pressToCancel);
    on<AddData>(_addData);

    add(GetVersionList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  final FilePickerRepo _filePickerRepo;

  FutureOr<void> _assignmentIdForEdit(
      AssignmentIdForEdit event, Emitter<AssignmentCreateState> emit) async {
    if (event.assignmentId != -1) {
      final details = await _apiRepo.get<AssignmentDetails>(
        endpoint: assignmentDetailsEndPoint(
            dId: event.assignmentId,
            sId: _localStorageRepo.read(key: loginIdDB)!),
      );

      if (details != null) {
        emit(state.copyWith(assingmentDtls: details));
        add(SelectVersionId(id: details.data!.subject!.versionId!));
        add(SelectClassId(id: details.data!.subject!.classId!));
        add(SelectSubjectId(id: details.data!.subject!.id!));
      }
    }
  }

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<AssignmentCreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _getFile(
      GetFile event, Emitter<AssignmentCreateState> emit) async {
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
      RemoveFile event, Emitter<AssignmentCreateState> emit) {
    emit(state.copyWith(
        fileList: List.from(state.fileList)..removeAt(event.index)));
  }

  FutureOr<void> _submitable(
      Submitable event, Emitter<AssignmentCreateState> emit) {
    emit(state.copyWith(isSubmitable: event.isSubmitable));
  }

  FutureOr<void> _assessment(
      Assessment event, Emitter<AssignmentCreateState> emit) {
    emit(state.copyWith(isAssessment: event.isAssessment));
  }

  FutureOr<void> _changeMark(
      ChangeMark event, Emitter<AssignmentCreateState> emit) {
    emit(state.copyWith(mark: event.mark));
  }

  FutureOr<void> _startDate(
      StartDate event, Emitter<AssignmentCreateState> emit) {
    final date = getDate(value: event.startDate, formate: "yyyy-MM-dd");
    emit(state.copyWith(startDate: date));
  }

  FutureOr<void> _endDate(EndDate event, Emitter<AssignmentCreateState> emit) {
    emit(state.copyWith(endDate: event.endDate));
  }

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<AssignmentCreateState> emit) async {
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
      SelectVersionId event, Emitter<AssignmentCreateState> emit) {
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
        sectionList: [],
        assignToBatchId: [],
        batchWiseStudent: [],
      ));
    }
  }

  FutureOr<void> _selectClassId(
      SelectClassId event, Emitter<AssignmentCreateState> emit) {
    final data = state.bacthAsSection.data!;
    List<DropdownItem> subjectList = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (event.id != state.selectedClassId) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].versionId == state.selectedVersionId) {
          for (int j = 0; j < data[i].classes!.length; j++) {
            if (data[i].classes![j].classId == event.id) {
              emit(state.copyWith(
                  selecteClassName: data[i].classes![j].className));
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
        sectionList: [],
        assignToBatchId: [],
        batchWiseStudent: [],
      ));
    }
  }

  FutureOr<void> _selectSubjectId(
      SelectSubjectId event, Emitter<AssignmentCreateState> emit) {
    final data = state.bacthAsSection.data!;
    List<DropDownValueModel> sectionList = [];

    if (event.id != state.selectedSubjectId) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].versionId == state.selectedVersionId) {
          for (int j = 0; j < data[i].classes!.length; j++) {
            if (data[i].classes![j].classId == state.selectedClassId) {
              for (int k = 0; k < data[i].classes![j].subjects!.length; k++) {
                if (data[i].classes![j].subjects![k].subjectId == event.id) {
                  final sections = data[i].classes![j].subjects![k].sections!;
                  for (int l = 0; l < sections.length; l++) {
                    sectionList.add(DropDownValueModel(
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
        assignToBatchId: [],
        batchWiseStudent: [],
      ));
    }
  }

  // FutureOr<void> _selectSectionId(
  //     SelectSectionId event, Emitter<AssignmentCreateState> emit) {
  //   emit(state.copyWith(selectSectionId: event.id));
  // }

  FutureOr<void> _selectSectionList(
      SelectSectionList event, Emitter<AssignmentCreateState> emit) async {
    List<int> batchIdList = [];
    List<String> batchNames = [];
    for (int i = 0; i < event.sectionList.length; i++) {
      batchIdList.add(event.sectionList[i].value);
      batchNames.add(event.sectionList[i].name);
    }
    emit(state.copyWith(
      assignToBatchId: batchIdList,
      selectedBatchName: batchNames,
      batchLoading: true,
    ));

    List<BatchWiseStudent> batchWiseStudentList = [];
    List<List<CheckUncheckStudents>> listCheckUncheck = [];
    List<CheckUncheckStudents> checkUncheck = [];

    for (int i = 0; i < state.assignToBatchId.length; i++) {
      final student = await _apiRepo.get<BatchWiseStudent>(
          endpoint: getBatchWiseStudentsEndpoint(
              subjectId: state.selectedSubjectId,
              batchId: state.assignToBatchId[i]));

      if (student != null) {
        batchWiseStudentList.add(student);

        if (student.data != null) {
          for (int j = 0; j < student.data!.length; j++) {
            checkUncheck.add(CheckUncheckStudents(
              id: student.data![j].id!,
              isChecked: true,
              name: student.data![j].name!,
              admissionRoll: student.data![j].admissionNumber!,
            ));
          }
          listCheckUncheck.add(checkUncheck);
          checkUncheck = [];
        }
      }
    }

    emit(state.copyWith(
      batchWiseStudent: batchWiseStudentList,
      tempBatchWiseStudent: batchWiseStudentList,
      batchLoading: false,
      listOfCheckUncheckStudent: listCheckUncheck,
    ));
  }

  FutureOr<void> _backWithUnselected(
      BackWithUnselected event, Emitter<AssignmentCreateState> emit) {
    List<List<CheckUncheckStudents>> updateStudents =
        state.listOfCheckUncheckStudent;

    updateStudents[event.index] = event.students;
    emit(state.copyWith(listOfCheckUncheckStudent: updateStudents));
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<AssignmentCreateState> emit) async {
    List<int> studentList = [];

    for (int i = 0; i < state.listOfCheckUncheckStudent.length; i++) {
      for (int j = 0; j < state.listOfCheckUncheckStudent[i].length; j++) {
        if (state.listOfCheckUncheckStudent[i][j].isChecked) {
          studentList.add(state.listOfCheckUncheckStudent[i][j].id);
        }
      }
    }

    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final create = await _apiRepo.appMultipart<DefaultResponse, void>(
        endpoint: assignmentCreateEndPoint,
        body: {
          "status": event.isDraft ? 0 : 1,
          "title": state.title,
          "description": event.content,
          "published_at": state.startDate,
          "due_at": state.endDate,
          "subject_id": state.selectedSubjectId,
          "is_markable": state.isAssessment ? '1' : '0',
          "assign_to_student": studentList,
          "marks": state.mark,
          "assign_to_batch": state.assignToBatchId,
          "submission_required": state.isSubmitable ? 1 : 0,
        },
        fileFieldName: "assignment_attachment__url",
        files: state.fileList,
      );

      if (create != null) {
        _iFlutterNavigator.pop();
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            teacherAssignmentListScreen, ModalRoute.withName('/'));
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
      FormItem(text: state.mark, focusNode: event.markFocusnode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.title.isEmpty ||
        state.startDate.isEmpty ||
        state.endDate.isEmpty ||
        state.isAssessment && state.mark.isEmpty ||
        state.selectedSubjectId == -1 ||
        state.assignToBatchId.isEmpty) {
      return false;
    }
    return true;
  }

  FutureOr<void> _pressToCancel(
      PressToCancel event, Emitter<AssignmentCreateState> emit) {
    showCancelDialog(_iFlutterNavigator.context, pressToYes: () {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          teacherAssignmentListScreen, ModalRoute.withName('/'));
    });
  }

  FutureOr<void> _addData(AddData event, Emitter<AssignmentCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        title: event.title,
        mark: event.mark.toString(),
        startDate: event.startDate,
        endDate: event.endDate,
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        isFirstTime: false,
      ));
    }
  }
}
