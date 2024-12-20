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
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/assignment_assign_student_response.dart';
import 'package:school_of_future/features/domain/entities/batch_wise_student.dart';
import 'package:school_of_future/features/domain/entities/classwork_details_response.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'class_work_create_event.dart';
part 'class_work_create_state.dart';

class ClassWorkCreateBloc
    extends Bloc<ClassWorkCreateEvent, ClassWorkCreateState> {
  ClassWorkCreateBloc(this._apiRepo, this._iFlutterNavigator,
      this._localStorageRepo, this._filePickerRepo)
      : super(ClassWorkCreateInitial()) {
    on<ClassworkIdForEdit>(_classworkIdForEdit);
    on<ChangeTitle>(_changeTitle);
    on<PublishDate>(_publishDate);
    on<GetFile>(_getFile);
    on<RemoveFile>(_removeFile);
    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    on<SelectSectionId>(_selectSectionId);
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

  FutureOr<void> _classworkIdForEdit(
      ClassworkIdForEdit event, Emitter<ClassWorkCreateState> emit) async {
    emit(state.copyWith(classWorkId: event.classworkId));
  }

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<ClassWorkCreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _publishDate(
      PublishDate event, Emitter<ClassWorkCreateState> emit) {
    final date = getDate(value: event.publishedAt, formate: "yyyy-MM-dd");
    emit(state.copyWith(publishedAt: date));
  }

  FutureOr<void> _getFile(
      GetFile event, Emitter<ClassWorkCreateState> emit) async {
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
      RemoveFile event, Emitter<ClassWorkCreateState> emit) {
    emit(state.copyWith(
        fileList: List.from(state.fileList)..removeAt(event.index)));
  }

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<ClassWorkCreateState> emit) async {
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

      if (state.classWorkId != -1) {
        final details = await _apiRepo.get<ClassworkDetails>(
          endpoint: classworkDetailsEndPoint(id: state.classWorkId),
        );

        if (details != null) {
          emit(state.copyWith(classworkDtls: details));

          add(SelectVersionId(
              id: state.classworkDtls.data!.subject!.versionId!));
          add(SelectClassId(id: state.classworkDtls.data!.subject!.classId!));
          add(SelectSubjectId(id: state.classworkDtls.data!.subject!.id!));
        }
      }
    }
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<ClassWorkCreateState> emit) {
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
      SelectClassId event, Emitter<ClassWorkCreateState> emit) {
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
      SelectSubjectId event, Emitter<ClassWorkCreateState> emit) {
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

  FutureOr<void> _selectSectionId(
      SelectSectionId event, Emitter<ClassWorkCreateState> emit) {}

  FutureOr<void> _selectSectionList(
      SelectSectionList event, Emitter<ClassWorkCreateState> emit) async {
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

      if (student != null && state.classWorkId == -1) {
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
      } else {
        batchWiseStudentList.add(student!);
        if (student.data != null) {
          for (int j = 0; j < student.data!.length; j++) {
            if (state.classworkDtls.data!.assignStudents!
                .contains(student.data![j].id)) {
              checkUncheck.add(CheckUncheckStudents(
                id: student.data![j].id!,
                isChecked: true,
                name: student.data![j].name!,
                admissionRoll: student.data![j].admissionNumber!,
              ));
            } else {
              checkUncheck.add(CheckUncheckStudents(
                id: student.data![j].id!,
                isChecked: false,
                name: student.data![j].name!,
                admissionRoll: student.data![j].admissionNumber!,
              ));
            }
          }
          listCheckUncheck.add(checkUncheck);
          checkUncheck = [];
        }
      }
    }

    emit(state.copyWith(
      batchWiseStudent: batchWiseStudentList,
      // tempBatchWiseStudent: batchWiseStudentList,
      batchLoading: false,
      listOfCheckUncheckStudent: listCheckUncheck,
    ));
  }

  FutureOr<void> _backWithUnselected(
      BackWithUnselected event, Emitter<ClassWorkCreateState> emit) {
    emit(state.copyWith(batchLoading: true));
    List<List<CheckUncheckStudents>> updateStudents =
        state.listOfCheckUncheckStudent;

    updateStudents[event.index] = event.students;
    emit(state.copyWith(
        listOfCheckUncheckStudent: updateStudents, batchLoading: false));
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<ClassWorkCreateState> emit) async {
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
        endpoint: state.classWorkId != -1
            ? classworkDetailsEndPoint(id: state.classWorkId)
            : teacherClassworkEndPoint,
        body: {
          "status": event.isDraft ? 0 : 1,
          "title": state.title,
          "published_at": state.publishedAt,
          "description": event.content,
          "subject_id": state.selectedSubjectId,
          "assign_to_batch": state.assignToBatchId,
          "assigne_to_student": studentList,
          "_method": state.classWorkId == -1 ? "POST" : "PUT",
        },
        fileFieldName: "class_work_attachment__url",
        files: state.fileList,
      );

      if (create != null) {
        _iFlutterNavigator.pop();
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            classworkListScreen, ModalRoute.withName('/'));
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
        state.selectedSubjectId == -1 ||
        state.assignToBatchId.isEmpty) {
      return false;
    }
    return true;
  }

  FutureOr<void> _pressToCancel(
      PressToCancel event, Emitter<ClassWorkCreateState> emit) {
    showCancelDialog(_iFlutterNavigator.context, pressToYes: () {
      // _iFlutterNavigator.pop();
      // navigatorKey.currentState!.pushNamedAndRemoveUntil(
      //     classworkListScreen, ModalRoute.withName('/'));
      Navigator.popUntil(_iFlutterNavigator.context, (route) => route.isFirst);
    });
  }

  FutureOr<void> _addData(AddData event, Emitter<ClassWorkCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        title: event.title,
        publishedAt: getDate(value: event.publishAt, formate: "yyyy-MM-dd"),
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        isFirstTime: false,
      ));
    }
  }
}
