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

part 'question_bank_event.dart';
part 'question_bank_state.dart';

class QuestionBankBloc extends Bloc<QuestionBankEvent, QuestionBankState> {
  QuestionBankBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuestionBankInitial()) {
    on<GetQuestion>(_getQuestion);
    on<ChangeSearch>(_changeSearch);
    on<PressFilter>(_pressFilter);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteQuestion>(_deleteQuestion);
    on<PageIncrement>(_pageIncrement);

    add(GetQuestion());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQuestion(
      GetQuestion event, Emitter<QuestionBankState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "search": state.searchText,
      "subject_id": state.subjectId,
    };

    final questions = await _apiRepo.get<QuestionBankList>(
        endpoint: buildUrl(questionBankEndPoint, queryParams));

    if (questions != null) {
      emit(state.copyWith(questionList: questions));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<QuestionBankState> emit) {
    emit(state.copyWith(
      searchText: event.searchText,
      subjectId: event.filterBloc.state.selectedSubjectId,
    ));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetQuestion());
    });
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<QuestionBankState> emit) {
    emit(state.copyWith(subjectId: event.filterBloc.state.selectedSubjectId));
    add(GetQuestion());
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<QuestionBankState> emit) {
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
      DeleteQuestion event, Emitter<QuestionBankState> emit) async {
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
      PageIncrement event, Emitter<QuestionBankState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.questionList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "search": state.searchText,
          "subject_id": state.subjectId,
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
}
