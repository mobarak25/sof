import 'dart:async';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/confirm_cancel_dialog.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/assignment_assign_student_response.dart';
import 'package:school_of_future/features/domain/entities/batch_wise_student.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/entities/question_level_response.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_teacher_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'create_quiz_event.dart';
part 'create_quiz_state.dart';

class CreateQuizBloc extends Bloc<CreateQuizEvent, CreateQuizState> {
  CreateQuizBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(CreateQuizInitial()) {
    on<QuizIdForEdit>(_quizIdForEdit);
    on<ChangeTitle>(_changeTitle);
    on<StartDate>(_startDate);
    on<EndDate>(_endDate);
    on<ChangeDuration>(_changeDuration);
    on<ChangePassPercentage>(_changePassPercentage);
    on<ChangeGraceTime>(_changeGraceTime);
    on<IsCommon>(_isCommon);
    on<AllowLateSub>(_allowLateSub);
    on<IsMarkEditable>(_isMarkEditable);
    on<AllowRetake>(_allowRetake);
    on<CheckSubjectId>(_checkSubjectId);
    on<SelectedQuestions>(_selectedQuestions);

    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    on<SelectSectionId>(_selectSectionId);
    on<SelectLeevelId>(_selectLeevelId);
    on<SelectSectionList>(_selectSectionList);
    on<BackWithUnselected>(_backWithUnselected);
    on<GetQuestionLevel>(_getQuestionLevel);
    on<PressToCreate>(_pressToCreate);
    on<PressToCancel>(_pressToCancel);
    on<AddData>(_addData);

    add(GetVersionList());
    add(GetQuestionLevel());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _quizIdForEdit(
      QuizIdForEdit event, Emitter<CreateQuizState> emit) async {
    emit(state.copyWith(quizId: event.quizId));

    if (event.quizId != -1) {
      final details = await _apiRepo.get<QuizDetailsForTeacher>(
        endpoint: quizDtlsEndPoint(id: event.quizId),
      );

      if (details != null) {
        emit(state.copyWith(quizDtls: details));

        add(SelectVersionId(id: state.quizDtls.data!.subject!.versionId!));
        add(SelectClassId(id: state.quizDtls.data!.subject!.classId!));
        add(SelectSubjectId(id: state.quizDtls.data!.subject!.id!));
      }
    }
  }

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _startDate(StartDate event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(startDate: event.startDate));
  }

  FutureOr<void> _endDate(EndDate event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(endDate: event.endDate));
  }

  FutureOr<void> _changeDuration(
      ChangeDuration event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(duration: event.duration));
  }

  FutureOr<void> _changePassPercentage(
      ChangePassPercentage event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(passPercentage: event.passPercentage));
  }

  FutureOr<void> _changeGraceTime(
      ChangeGraceTime event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(graceTime: event.graceTime));
  }

  FutureOr<void> _isCommon(IsCommon event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(isCommon: event.common));
  }

  FutureOr<void> _allowLateSub(
      AllowLateSub event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(allowLateSub: event.isLateSub));
  }

  FutureOr<void> _isMarkEditable(
      IsMarkEditable event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(isMarkEditable: event.isMarkEditable));
  }

  FutureOr<void> _allowRetake(
      AllowRetake event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(allowRetake: event.allowRetake));
  }

  FutureOr<void> _checkSubjectId(
      CheckSubjectId event, Emitter<CreateQuizState> emit) {
    if (event.id == -1) {
      ShowSnackBar(
          message: "Please Select subject",
          color: bRed,
          navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<CreateQuizState> emit) async {
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

      if (state.quizId != -1) {
        add(GetQuestionLevel());

        final details = await _apiRepo.get<QuizDetailsForTeacher>(
          endpoint: quizDtlsEndPoint(id: state.quizId),
        );

        if (details != null) {
          emit(state.copyWith(quizDtls: details));
          final data = state.quizDtls.data!;

          add(SelectVersionId(id: data.subject!.versionId));
          add(SelectClassId(id: data.subject!.classId));
          add(SelectSubjectId(id: data.subjectId));

          List<TempQuestion> selectedQstns = [];
          num fullmark = 0;

          for (int i = 0; i < data.questions!.length; i++) {
            selectedQstns.add(TempQuestion(
                id: data.questions![i].id!,
                title: data.questions![i].title!,
                focusnode: FocusNode(),
                textEditingController: TextEditingController(
                    text: data.questions![i].pivot!.mark!.toString())));

            fullmark += data.questions![i].pivot!.mark!;
          }

          add(
            AddData(
              title: data.title!,
              startDate: data.startDateTime!,
              endDate: data.endDateTime!,
              duration: data.duration!.toString(),
              passPercentage: data.pass!,
              graceTime: data.greaseTime!,
              isCommon: data.isCommon!,
              allowLateSub: data.allowLateSubmission!,
              isMarkEditable: data.markEditable!,
              allowRetake: data.allowRetake!,
              selectedVersionId: data.subject!.versionId,
              selectedClassId: data.subject!.classId!,
              selectedSubjectId: data.subjectId,
              selectLevelId: data.questionLevelId,
              selectedQstns: selectedQstns,
              fullMark: fullmark,
            ),
          );
        }
      }
    }
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<CreateQuizState> emit) {
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
      SelectClassId event, Emitter<CreateQuizState> emit) {
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
      SelectSubjectId event, Emitter<CreateQuizState> emit) {
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
      SelectSectionId event, Emitter<CreateQuizState> emit) {}

  FutureOr<void> _selectSectionList(
      SelectSectionList event, Emitter<CreateQuizState> emit) async {
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

      if (student != null && state.quizId == -1) {
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
            if (state.quizDtls.data!.assignStudents!
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
      BackWithUnselected event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(batchLoading: true));
    List<List<CheckUncheckStudents>> updateStudents =
        state.listOfCheckUncheckStudent;

    updateStudents[event.index] = event.students;
    emit(state.copyWith(
        listOfCheckUncheckStudent: updateStudents, batchLoading: false));
  }

  FutureOr<void> _pressToCancel(
      PressToCancel event, Emitter<CreateQuizState> emit) {
    showCancelDialog(_iFlutterNavigator.context, pressToYes: () {
      Navigator.popUntil(_iFlutterNavigator.context, (route) => route.isFirst);
    });
  }

  FutureOr<void> _addData(AddData event, Emitter<CreateQuizState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        title: event.title,
        startDate: event.startDate,
        endDate: event.endDate,
        duration: event.duration,
        passPercentage: event.passPercentage.toString(),
        graceTime: event.graceTime.toString(),
        isCommon: event.isCommon == 0 ? false : true,
        allowLateSub: event.allowLateSub == 0 ? false : true,
        isMarkEditable: event.isMarkEditable == 0 ? false : true,
        allowRetake: event.allowRetake == 0 ? false : true,
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        selectLevelId: event.selectLevelId,
        selectedQstns: event.selectedQstns,
        fullMarks: event.fullMark,
        isFirstTime: false,
      ));
    }
  }

  FutureOr<void> _selectedQuestions(
      SelectedQuestions event, Emitter<CreateQuizState> emit) {
    num totalMarks = event.qst.fold(
        0,
        (sum, item) =>
            sum +
            num.parse(item.textEditingController.text.isEmpty
                ? '0'
                : item.textEditingController.text));
    emit(state.copyWith(selectedQstns: event.qst, fullMarks: totalMarks));
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<CreateQuizState> emit) async {
    List<int> studentList = [];
    List<int> questionId = [];
    List<String> questionMark = [];

    for (int i = 0; i < state.listOfCheckUncheckStudent.length; i++) {
      for (int j = 0; j < state.listOfCheckUncheckStudent[i].length; j++) {
        if (state.listOfCheckUncheckStudent[i][j].isChecked) {
          studentList.add(state.listOfCheckUncheckStudent[i][j].id);
        }
      }
    }

    for (int i = 0; i < state.selectedQstns.length; i++) {
      questionId.add(state.selectedQstns[i].id);
      questionMark.add(state.selectedQstns[i].textEditingController.text);
    }

    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final create = await _apiRepo.post<DefaultResponse>(
        endpoint: state.quizId != -1
            ? quizDtlsEndPoint(id: state.quizId)
            : quizEndPoint,
        body: {
          "title": state.title,
          "is_common": state.isCommon ? 1 : 0,
          "allow_late_submission": state.allowLateSub ? 1 : 0,
          "mark_editable": state.isMarkEditable ? 1 : 0,
          "start_date_time": state.startDate,
          "end_date_time": state.endDate,
          "duration": state.duration,
          "pass": state.passPercentage,
          "subject_id": state.selectedSubjectId,
          "grease_time": state.graceTime,
          "allow_retake": state.allowRetake ? 1 : 0,
          "question_id": questionId,
          "question_level_id": state.selectLevelId,
          "question_mark": questionMark,
          "student_id": state.isCommon ? [] : studentList,
          "_method": state.quizId == -1 ? "POST" : "PUT",
        },
      );

      if (create != null) {
        _iFlutterNavigator.pop();
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil(quizListScreen, ModalRoute.withName('/'));
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
    if (state.title.isEmpty || state.selectedSubjectId == -1) {
      return false;
    }
    return true;
  }

  FutureOr<void> _getQuestionLevel(
      GetQuestionLevel event, Emitter<CreateQuizState> emit) async {
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

  FutureOr<void> _selectLeevelId(
      SelectLeevelId event, Emitter<CreateQuizState> emit) {
    emit(state.copyWith(selectLevelId: event.id));
  }
}
