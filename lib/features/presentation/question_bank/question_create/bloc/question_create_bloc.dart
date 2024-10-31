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
import 'package:school_of_future/features/domain/entities/question_details_response.dart';
import 'package:school_of_future/features/domain/entities/question_level_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'question_create_event.dart';
part 'question_create_state.dart';

class QuestionCreateBloc
    extends Bloc<QuestionCreateEvent, QuestionCreateState> {
  QuestionCreateBloc(this._apiRepo, this._iFlutterNavigator,
      this._localStorageRepo, this._filePickerRepo)
      : super(QuestionCreateInitial()) {
    on<QuestionIdForEdit>(_questionIdForEdit);
    on<ChangeTitle>(_changeTitle);
    on<ChangeMark>(_changeMark);
    on<GetFile>(_getFile);
    on<GetOptionFile>(_getOptionFile);
    on<RemoveFile>(_removeFile);
    on<RemoveOptionFile>(_removeOptionFile);
    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    on<SelectLeevelId>(_selectLeevelId);
    on<GetQuestionLevel>(_getQuestionLevel);
    on<SelectQuestionTypeId>(_selectQuestionTypeId);
    on<AddOptions>(_addOptions);
    on<SelectMcqOptions>(_selectMcqOptions);
    on<Explanation>(_explanation);
    on<ChangeCorAns>(_changeCorAns);
    on<PressToCreate>(_pressToCreate);
    on<PressToCancel>(_pressToCancel);
    on<PressToConfirmCancel>(_pressToConfirmCancel);
    on<AddData>(_addData);

    add(GetVersionList());
    add(GetQuestionLevel());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  final FilePickerRepo _filePickerRepo;

  FutureOr<void> _questionIdForEdit(
      QuestionIdForEdit event, Emitter<QuestionCreateState> emit) async {
    emit(state.copyWith(qId: event.qId));
  }

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<QuestionCreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _changeMark(
      ChangeMark event, Emitter<QuestionCreateState> emit) {
    emit(state.copyWith(mark: event.mark));
  }

  FutureOr<void> _explanation(
      Explanation event, Emitter<QuestionCreateState> emit) {
    emit(state.copyWith(explanation: event.explanation));
  }

  FutureOr<void> _changeCorAns(
      ChangeCorAns event, Emitter<QuestionCreateState> emit) {
    emit(state.copyWith(correctAns: event.corAns));
  }

  FutureOr<void> _getFile(
      GetFile event, Emitter<QuestionCreateState> emit) async {
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

  FutureOr<void> _getOptionFile(
      GetOptionFile event, Emitter<QuestionCreateState> emit) async {
    FilePickerResult? result =
        await _filePickerRepo.filePicker(isMultiple: false);

    if (result != null) {
      final files = result.paths
          .map((path) => path != null ? File(path) : File(''))
          .toList();

      List<File> updatedOptionImages = List.from(state.optionImage);
      List<int> updatedHasOptionImg = List.from(state.hasOptionImg);

      updatedOptionImages[event.index] = files[0];
      updatedHasOptionImg[event.index] = 1;

      emit(
        state.copyWith(
          optionImage: updatedOptionImages,
          hasOptionImg: updatedHasOptionImg,
        ),
      );

      print("has image===============${state.hasOptionImg}");
    } else {}
  }

  FutureOr<void> _removeFile(
      RemoveFile event, Emitter<QuestionCreateState> emit) {
    emit(state.copyWith(
        fileList: List.from(state.fileList)..removeAt(event.index)));
  }

  FutureOr<void> _removeOptionFile(
      RemoveOptionFile event, Emitter<QuestionCreateState> emit) {
    List<File> updateFiles = List.from(state.optionImage);
    List<int> updateHasImg = List.from(state.hasOptionImg);

    updateFiles[event.index] = File('02943e5368adf6cc72f4a2e0a435090b.pdf');
    updateHasImg[event.index] = 0;

    emit(state.copyWith(optionImage: updateFiles, hasOptionImg: updateHasImg));

    print(state.hasOptionImg);
  }

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<QuestionCreateState> emit) async {
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

      if (state.qId != -1) {
        final details = await _apiRepo.get<QuestionDetails>(
          endpoint: questionDtlsEndPoint(qId: state.qId),
        );

        if (details != null) {
          emit(state.copyWith(questionDtls: details));
          final data = state.questionDtls.data!;

          add(SelectVersionId(id: data.subject!.versionId!));
          add(SelectClassId(id: data.subject!.classId));
          add(SelectSubjectId(id: data.subjectId));

          List<MCQOptions> option = [];
          List<int> checked = [];
          List<int> hasOptionImg = [];
          List<File> optionImage = [];

          for (int i = 0; i < data.questionOptions!.length; i++) {
            option.add(MCQOptions(
              textEditingController:
                  TextEditingController(text: data.questionOptions![i].options),
              focusnode: FocusNode(),
            ));
            checked.add(data.questionOptions![i].isCorrect!);
            hasOptionImg.add(data.questionOptions![i].imgHas!);
            optionImage.add(File("02943e5368adf6cc72f4a2e0a435090b.pdf"));
          }

          add(
            AddData(
              title: data.title!,
              explanation: data.questionExplanation!,
              mark: data.mark.toString(),
              selectedVersionId: data.subject!.versionId!,
              selectedClassId: data.subject!.classId!,
              selectedSubjectId: data.subjectId,
              selectLevelId: data.questionLevelId,
              questionTypeId: data.type,
              mcqOptions: option,
              checked: checked,
              hasOptionImg: hasOptionImg,
              selectedMcqOption: checked.indexOf(1),
              optionImage: optionImage,
              correctAns: data.correctAnswer,
            ),
          );
        }
      }
    }
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<QuestionCreateState> emit) {
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
        selectedClassId: -1,
        selectedSubjectId: -1,
        classList: classList,
        subjectList: [const DropdownItem(name: "Select", value: -1)],
      ));
    }
  }

  FutureOr<void> _selectClassId(
      SelectClassId event, Emitter<QuestionCreateState> emit) {
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
        selectedSubjectId: -1,
        subjectList: subjectList,
      ));
    }
  }

  FutureOr<void> _selectSubjectId(
      SelectSubjectId event, Emitter<QuestionCreateState> emit) {
    if (event.id != state.selectedSubjectId) {
      emit(state.copyWith(selectedSubjectId: event.id));
    }
  }

  FutureOr<void> _selectLeevelId(
      SelectLeevelId event, Emitter<QuestionCreateState> emit) {
    emit(state.copyWith(selectLevelId: event.id));
  }

  FutureOr<void> _getQuestionLevel(
      GetQuestionLevel event, Emitter<QuestionCreateState> emit) async {
    final lavel =
        await _apiRepo.get<QuestionLevel>(endpoint: questionLevelEndPoint);

    if (lavel != null) {
      List<DropdownItem> list = [const DropdownItem(name: "Select", value: -1)];

      for (int i = 0; i < lavel.data!.length; i++) {
        list.add(DropdownItem(
            name: lavel.data![i].levelValue!, value: lavel.data![i].level!));
      }
      emit(state.copyWith(questionLevel: list));
    }
  }

  FutureOr<void> _selectQuestionTypeId(
      SelectQuestionTypeId event, Emitter<QuestionCreateState> emit) {
    emit(state.copyWith(questionTypeId: event.id));
  }

  FutureOr<void> _addOptions(
      AddOptions event, Emitter<QuestionCreateState> emit) {
    emit(
      state.copyWith(
        checked: List.from(state.checked)..add(0),
        hasOptionImg: List.from(state.hasOptionImg)..add(0),
        optionImage: List.from(state.optionImage)
          ..add(File('02943e5368adf6cc72f4a2e0a435090b.pdf')),
        mcqOptions: List.from(state.mcqOptions)
          ..add(
            MCQOptions(
              textEditingController: TextEditingController(),
              focusnode: FocusNode(),
            ),
          ),
      ),
    );

    print("Checked===========: ${state.checked}");
    print("has option image===========: ${state.hasOptionImg}");
  }

  FutureOr<void> _selectMcqOptions(
      SelectMcqOptions event, Emitter<QuestionCreateState> emit) {
    List<int> updatedChecked = List<int>.filled(
        state.questionTypeId == 1
            ? state.checked.length
            : state.questionTypeId == 2
                ? 2
                : 1,
        0);
    updatedChecked[event.optionIndex] = 1;

    emit(state.copyWith(
        selectedMcqOption: event.optionIndex, checked: updatedChecked));
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<QuestionCreateState> emit) async {
    List<String> optionList = [];

    for (int i = 0; i < state.mcqOptions.length; i++) {
      optionList.add(state.mcqOptions[i].textEditingController.text);
    }

    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final create = await _apiRepo.appMultipart<DefaultResponse, void>(
        endpoint: state.qId != -1
            ? questionDtlsEndPoint(qId: state.qId)
            : questionBankEndPoint,
        body: {
          "is_temp": event.isDraft ? 0 : 1,
          "title": state.title,
          "mark": state.mark,
          "question_level_id": state.selectLevelId,
          "type": state.questionTypeId,
          "options": state.questionTypeId == 1
              ? optionList
              : state.questionTypeId == 2
                  ? ["True", "False"]
                  : [],
          "subject_id": state.selectedSubjectId,
          "correct_answer": state.correctAns,
          "question_explanation": state.explanation,
          "checked": state.checked,
          "img_has": state.questionTypeId == 1
              ? state.hasOptionImg
              : state.questionTypeId == 2
                  ? [0, 0]
                  : [],
          "_method": state.qId == -1 ? "POST" : "PUT",
        },
        fileFieldName: "question_thumbnail",
        thumbFieldName: "thumbnails",
        files: state.fileList,
        thumbFiles: state.questionTypeId == 1 ? state.optionImage : [],
      );

      if (create != null) {
        // _iFlutterNavigator.pop();
        _iFlutterNavigator.popUntil((route) => route.isFirst);
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            questionBankScreen, ModalRoute.withName('/'));
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
        state.mark.isEmpty ||
        state.selectedSubjectId == -1 ||
        state.questionTypeId == -1 ||
        state.selectLevelId == -1) {
      return false;
    }
    return true;
  }

  FutureOr<void> _pressToCancel(
      PressToCancel event, Emitter<QuestionCreateState> emit) {
    showCancelDialog(_iFlutterNavigator.context, pressToYes: () {
      add(PressToConfirmCancel());
    });
  }

  FutureOr<void> _pressToConfirmCancel(
      PressToConfirmCancel event, Emitter<QuestionCreateState> emit) {
    Navigator.of(_iFlutterNavigator.context).popUntil((route) => route.isFirst);
  }

  FutureOr<void> _addData(AddData event, Emitter<QuestionCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        title: event.title,
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        selectLevelId: event.selectLevelId,
        questionTypeId: event.questionTypeId,
        mark: event.mark,
        isFirstTime: false,
        mcqOptions: event.mcqOptions,
        hasOptionImg: event.hasOptionImg,
        selectedMcqOption: event.selectedMcqOption,
        checked: event.checked,
        optionImage: event.optionImage,
        explanation: event.explanation,
        correctAns: event.correctAns,
      ));
    }
  }
}
