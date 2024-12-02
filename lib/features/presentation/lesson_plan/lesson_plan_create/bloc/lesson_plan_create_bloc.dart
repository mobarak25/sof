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
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/entities/lesson_plan_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_create/widgets/attechment_bottom_sheet.dart';

part 'lesson_plan_create_event.dart';
part 'lesson_plan_create_state.dart';

class LessonPlanCreateBloc
    extends Bloc<LessonPlanCreateEvent, LessonPlanCreateState> {
  LessonPlanCreateBloc(this._apiRepo, this._iFlutterNavigator,
      this._localStorageRepo, this._filePickerRepo)
      : super(LessonPlanCreateInitial()) {
    on<PlanIdForEdit>(_planIdForEdit);
    on<ChangeTitle>(_changeTitle);
    on<OpenBottomSheet>(_openBottomSheet);
    on<GetFile>(_getFile);
    on<RemoveFile>(_removeFile);
    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    on<SelectSectionId>(_selectSectionId);
    on<GetSelectedResourceIds>(_getSelectedResourceIds);
    on<PressToCreate>(_pressToCreate);
    on<PressToCancel>(_pressToCancel);
    on<PressToConfirmCancel>(_pressToConfirmCancel);
    on<AddData>(_addData);

    add(GetVersionList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  final FilePickerRepo _filePickerRepo;

  FutureOr<void> _planIdForEdit(
      PlanIdForEdit event, Emitter<LessonPlanCreateState> emit) async {
    emit(state.copyWith(planId: event.planId));
  }

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<LessonPlanCreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _openBottomSheet(
      OpenBottomSheet event, Emitter<LessonPlanCreateState> emit) {
    openAttechmentSheet(_iFlutterNavigator.context, press: (String btnType) {
      if (btnType == "uploadFile") {
        add(GetFile());
      } else {
        Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
            .pushNamed(teacherAttachResourceScreen, arguments: state.checkedIds)
            .then((value) {
          final backWithUnselected = value as List<CheckUncheckResources>;
          List<int> idList = [];

          for (int i = 0; i < backWithUnselected.length; i++) {
            if (backWithUnselected[i].isChecked) {
              idList.add(backWithUnselected[i].id);
            }
          }
          add(GetSelectedResourceIds(resourceIds: idList));
        });
      }
    });
  }

  FutureOr<void> _getSelectedResourceIds(
      GetSelectedResourceIds event, Emitter<LessonPlanCreateState> emit) {
    Navigator.pop(_iFlutterNavigator.context);
    emit(state.copyWith(checkedIds: event.resourceIds));
  }

  FutureOr<void> _getFile(
      GetFile event, Emitter<LessonPlanCreateState> emit) async {
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
      RemoveFile event, Emitter<LessonPlanCreateState> emit) {
    emit(state.copyWith(
        fileList: List.from(state.fileList)..removeAt(event.index)));
  }

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<LessonPlanCreateState> emit) async {
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

      if (state.planId != -1) {
        final details = await _apiRepo.get<LessonPlanDetails>(
          endpoint: teacherLessonPlanDetailsEndPoint(planId: state.planId),
        );

        if (details != null) {
          final data = details.data!;
          List<int> idList = [];
          for (int i = 0; i < details.data!.resources!.length; i++) {
            idList.add(details.data!.resources![i].resourceId!);
          }

          emit(state.copyWith(planDtls: details, checkedIds: idList));

          add(SelectVersionId(id: data.version!.id!));
          add(SelectClassId(id: data.dataClass!.id!));
          add(SelectSubjectId(id: data.subject!.id!));
          add(SelectSectionId(id: data.section!.id!));
        }
      }
    }
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<LessonPlanCreateState> emit) {
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
      SelectClassId event, Emitter<LessonPlanCreateState> emit) {
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
      SelectSubjectId event, Emitter<LessonPlanCreateState> emit) {
    final data = state.bacthAsSection.data!;
    List<DropdownItem> sectionList = [];

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
      SelectSectionId event, Emitter<LessonPlanCreateState> emit) {
    emit(state.copyWith(selectSectionId: event.id));
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<LessonPlanCreateState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final create = await _apiRepo.appMultipart<DefaultResponse, void>(
        endpoint: state.planId != -1
            ? teacherLessonPlanDetailsEndPoint(planId: state.planId)
            : teacherlessonPlanCreateEndPoint,
        body: {
          "status": event.isDraft ? 0 : 1,
          "title": state.title,
          "content": event.content == "<br> " ? '' : event.content,
          "objectives": event.objectiveContent,
          "version_id": state.selectedVersionId,
          "class_id": state.selectedClassId,
          "subject_id": state.selectedSubjectId,
          "section_id": state.selectSectionId,
          "lesson_plan_resource__id": state.checkedIds,
          "_method": state.planId == -1 ? "POST" : "PUT",
        },
        fileFieldName: "lesson_plan_attachment__url",
        files: state.fileList,
      );

      if (create != null) {
        // _iFlutterNavigator.pop();
        _iFlutterNavigator.popUntil((route) => route.isFirst);
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            lessonPlanListScreen, ModalRoute.withName('/'));
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
        state.selectedVersionId == -1 ||
        state.selectedClassId == -1 ||
        state.selectedSubjectId == -1 ||
        state.selectedVersionId == -1) {
      return false;
    }
    return true;
  }

  FutureOr<void> _pressToCancel(
      PressToCancel event, Emitter<LessonPlanCreateState> emit) {
    showCancelDialog(_iFlutterNavigator.context, pressToYes: () {
      add(PressToConfirmCancel());
    });
  }

  FutureOr<void> _pressToConfirmCancel(
      PressToConfirmCancel event, Emitter<LessonPlanCreateState> emit) {
    Navigator.of(_iFlutterNavigator.context).popUntil((route) => route.isFirst);
  }

  FutureOr<void> _addData(AddData event, Emitter<LessonPlanCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        title: event.title,
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        selectSectionId: event.selectedSectionId,
        isFirstTime: false,
      ));
    }
  }
}
