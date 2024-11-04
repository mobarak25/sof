import 'dart:async';
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
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/entities/question_paper_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'question_paper_create_event.dart';
part 'question_paper_create_state.dart';

class QuestionPaperCreateBloc
    extends Bloc<QuestionPaperCreateEvent, QuestionPaperCreateState> {
  QuestionPaperCreateBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuestionPaperCreateInitial()) {
    on<GetVersionList>(_getVersionList);
    on<QuestionPaperIdForEdit>(_questionPaperIdForEdit);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    on<CheckSubjectId>(_checkSubjectId);
    on<SelectSectionId>(_selectSectionId);
    on<ChangeTitle>(_changeTitle);
    on<StartDate>(_startDate);
    on<ChangeType>(_changeType);
    on<ChangeDuration>(_changeDuration);
    on<SelectedQuestions>(_selectedQuestions);
    on<PressToCreate>(_pressToCreate);
    on<AddData>(_addData);

    add(GetVersionList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<QuestionPaperCreateState> emit) async {
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

      if (state.qPaperId != -1) {
        final details = await _apiRepo.get<QuestionPaperDtls>(
          endpoint: questionPaperDtlsEndPoint(qId: state.qPaperId),
        );

        if (details != null) {
          emit(state.copyWith(questionDtls: details));
          final data = state.questionDtls.data!;

          add(SelectVersionId(id: data.batch!.versionId));
          add(SelectClassId(id: data.batch!.classId));
          add(SelectSubjectId(id: data.subjectId));
          add(SelectSectionId(id: data.batchId));

          List<TempQuestion> selectedQstns = [];

          num fullmark = 0;

          for (int i = 0; i < data.questionPaperContents!.length; i++) {
            selectedQstns.add(TempQuestion(
                id: data.questionPaperContents![i].questionId!,
                title: data.questionPaperContents![i].questions!.title!,
                focusnode: FocusNode(),
                textEditingController: TextEditingController(
                    text: data.questionPaperContents![i].questions!.mark!
                        .toString())));

            fullmark += data.questionPaperContents![i].questions!.mark!;
          }

          add(
            AddData(
              title: data.name!,
              startDate: data.datetime!,
              type: data.type!,
              duration: data.duration!,
              selectedVersionId: data.batch!.versionId!,
              selectedClassId: data.batch!.classId!,
              selectedSubjectId: data.subjectId,
              selectedSectionId: data.batchId,
              selectedQstns: selectedQstns,
              fullMark: fullmark,
            ),
          );
        }
      }
    }
  }

  FutureOr<void> _questionPaperIdForEdit(
      QuestionPaperIdForEdit event, Emitter<QuestionPaperCreateState> emit) {
    emit(state.copyWith(qPaperId: event.qPaperId));
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<QuestionPaperCreateState> emit) {
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
      SelectClassId event, Emitter<QuestionPaperCreateState> emit) {
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
      SelectSubjectId event, Emitter<QuestionPaperCreateState> emit) {
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

  FutureOr<void> _checkSubjectId(
      CheckSubjectId event, Emitter<QuestionPaperCreateState> emit) {
    if (event.id == -1) {
      ShowSnackBar(
          message: "Please Select subject",
          color: bRed,
          navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _selectSectionId(
      SelectSectionId event, Emitter<QuestionPaperCreateState> emit) {
    emit(state.copyWith(selectSectionId: event.id));
  }

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<QuestionPaperCreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _startDate(
      StartDate event, Emitter<QuestionPaperCreateState> emit) {
    final date = getDate(value: event.startDate, formate: "yyyy-MM-dd");

    emit(state.copyWith(startDate: date));
  }

  FutureOr<void> _changeType(
      ChangeType event, Emitter<QuestionPaperCreateState> emit) {
    emit(state.copyWith(paperType: event.type));
  }

  FutureOr<void> _changeDuration(
      ChangeDuration event, Emitter<QuestionPaperCreateState> emit) {
    emit(state.copyWith(duration: event.duration));
  }

  FutureOr<void> _selectedQuestions(
      SelectedQuestions event, Emitter<QuestionPaperCreateState> emit) {
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
      PressToCreate event, Emitter<QuestionPaperCreateState> emit) async {
    List<int> qIdList = [];
    List<String> qMarks = [];

    for (int i = 0; i < state.selectedQstns.length; i++) {
      qIdList.add(state.selectedQstns[i].id);
      qMarks.add(state.selectedQstns[i].textEditingController.text);
    }

    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final create = await _apiRepo.post<DefaultResponse>(
        endpoint: state.qPaperId != -1
            ? questionPaperDtlsEndPoint(qId: state.qPaperId)
            : questionPaperListEndPoint,
        body: {
          "subject_id": state.selectedSubjectId,
          "batch_id": state.selectedVersionId,
          "name": state.title,
          "type": state.paperType,
          "datetime": state.startDate,
          "duration": state.duration,
          "full_mark": state.fullMarks,
          "question_id": qIdList,
          "question_mark": qMarks,
          "_method": state.qPaperId == -1 ? "POST" : "PUT",
        },
      );

      if (create != null) {
        // _iFlutterNavigator.pop();
        _iFlutterNavigator.popUntil((route) => route.isFirst);
        navigatorKey.currentState!.pushNamedAndRemoveUntil(
            questionPaperListScreen, ModalRoute.withName('/'));
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
      FormItem(text: state.startDate, focusNode: event.startDateFocusnode),
      FormItem(text: state.paperType, focusNode: event.typeFocusnode),
      FormItem(text: state.duration, focusNode: event.durationFocusnode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.title.isEmpty ||
        state.startDate.isEmpty ||
        state.paperType.isEmpty ||
        state.duration.isEmpty ||
        state.selectedSubjectId == -1 ||
        state.selectSectionId == -1) {
      return false;
    }
    return true;
  }

  FutureOr<void> _addData(
      AddData event, Emitter<QuestionPaperCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        title: event.title,
        startDate: getDate(value: event.startDate, formate: "yyyy-MM-dd"),
        paperType: event.type,
        duration: event.duration,
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        selectSectionId: event.selectedSectionId,
        selectedQstns: event.selectedQstns,
        fullMarks: event.fullMark,
        isFirstTime: false,
      ));
    }
  }
}
