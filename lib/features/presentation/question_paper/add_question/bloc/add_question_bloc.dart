import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/debounce.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/confirm_delete_dialog.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/question_bank_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'add_question_event.dart';
part 'add_question_state.dart';

class AddQuestionBloc extends Bloc<AddQuestionEvent, AddQuestionState> {
  AddQuestionBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(AddQuestionInitial()) {
    on<GetQuestion>(_getQuestion);
    on<ChangeSearch>(_changeSearch);
    on<PressFilter>(_pressFilter);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteQuestion>(_deleteQuestion);
    on<PageIncrement>(_pageIncrement);
    on<CheckToggle>(_checkToggle);
    on<RemoveTempQst>(_removeTempQst);
    on<UpdateMarks>(_updateMarks);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQuestion(
      GetQuestion event, Emitter<AddQuestionState> emit) async {
    emit(state.copyWith(
        page: 1, loading: true, isEndList: false, subjectId: event.subjectId));
    final queryParams = {
      "page": state.page,
      "search": state.searchText,
      "subject_id": state.subjectId,
    };

    final questions = await _apiRepo.get<QuestionBankList>(
        endpoint: buildUrl(questionBankEndPoint, queryParams));

    if (questions != null) {
      List<QstTempChecked>? checkUncheck = [];
      for (int i = 0; i < questions.data!.length; i++) {
        bool isContained = event.tempQst
            .any((tempQuestion) => tempQuestion.id == questions.data![i].id!);

        if (isContained) {
          checkUncheck
              .add(QstTempChecked(id: questions.data![i].id!, isChecked: true));
        } else {
          checkUncheck.add(
              QstTempChecked(id: questions.data![i].id!, isChecked: false));
        }
      }
      emit(state.copyWith(
        questionList: questions,
        checkUncheck: checkUncheck,
        tempQst: event.tempQst,
        totalQst: event.tempQst.length,
        totalMarks: totalMrk(event.tempQst),
      ));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<AddQuestionState> emit) {
    emit(state.copyWith(
      searchText: event.searchText,
      subjectId: event.filterBloc.state.selectedSubjectId,
    ));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetQuestion(tempQst: state.tempQst, subjectId: state.subjectId));
    });
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<AddQuestionState> emit) {
    emit(state.copyWith(subjectId: event.filterBloc.state.selectedSubjectId));
    add(GetQuestion(tempQst: state.tempQst, subjectId: state.subjectId));
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<AddQuestionState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteQuestion(qId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(questionCreateScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteQuestion(
      DeleteQuestion event, Emitter<AddQuestionState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: questionDtlsEndPoint(qId: event.qId),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          questionBankScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<AddQuestionState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.questionList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "search": state.searchText,
          "subject_id": state.searchText,
        };

        final pagiQuestion = await _apiRepo.get<QuestionBankList>(
          endpoint: buildUrl(questionBankEndPoint, queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (pagiQuestion != null) {
          emit(state.copyWith(
              questionList: QuestionBankList(
            data: state.questionList.data! + pagiQuestion.data!,
            lastPage: pagiQuestion.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }

  FutureOr<void> _checkToggle(
      CheckToggle event, Emitter<AddQuestionState> emit) {
    List<TempQuestion> updateTempQst = List.from(state.tempQst);

    final updatedCopyOptions = state.checkUncheck.map((qstTempChecked) {
      if (qstTempChecked.id == event.item.id!) {
        return QstTempChecked(
          id: qstTempChecked.id,
          isChecked: event.isChecked,
        );
      }
      return qstTempChecked; // Return the student as-is if no update
    }).toList();

    if (event.isChecked) {
      updateTempQst.add(TempQuestion(
        id: event.item.id!,
        title: event.item.title!,
        focusnode: FocusNode(),
        textEditingController:
            TextEditingController(text: event.item.mark!.toString()),
      ));
    } else {
      updateTempQst.removeWhere((item) => item.id == event.item.id!);
    }

    emit(
      state.copyWith(
        checkUncheck: updatedCopyOptions,
        tempQst: updateTempQst,
        totalQst: updateTempQst.length,
        totalMarks: totalMrk(updateTempQst),
      ),
    );
  }

  FutureOr<void> _removeTempQst(
      RemoveTempQst event, Emitter<AddQuestionState> emit) {
    List<TempQuestion> updateTempQst = List.from(state.tempQst);
    updateTempQst.removeWhere((item) => item.id == event.id);

    final updatedCopyOptions = state.checkUncheck.map((qstTempChecked) {
      if (qstTempChecked.id == event.id) {
        return QstTempChecked(
          id: qstTempChecked.id,
          isChecked: false,
        );
      }
      return qstTempChecked; // Return the student as-is if no update
    }).toList();

    emit(state.copyWith(
      tempQst: updateTempQst,
      checkUncheck: updatedCopyOptions,
      totalQst: updateTempQst.length,
      totalMarks: totalMrk(updateTempQst),
    ));
  }

  FutureOr<void> _updateMarks(
      UpdateMarks event, Emitter<AddQuestionState> emit) {
    List<TempQuestion> updateTempQst = List.from(state.tempQst);
    emit(state.copyWith(totalMarks: totalMrk(updateTempQst)));
  }

  num totalMrk(List<TempQuestion> tempQ) {
    num totalMarks = tempQ.fold(
        0,
        (sum, item) =>
            sum +
            num.parse(item.textEditingController.text.isEmpty
                ? '0'
                : item.textEditingController.text));

    return totalMarks;
  }
}
