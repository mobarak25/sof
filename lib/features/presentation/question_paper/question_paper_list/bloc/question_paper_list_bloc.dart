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

import 'package:school_of_future/features/domain/entities/question_paper_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'question_paper_list_event.dart';
part 'question_paper_list_state.dart';

class QuestionPaperListBloc
    extends Bloc<QuestionPaperListEvent, QuestionPaperListState> {
  QuestionPaperListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuestionPaperListInitial()) {
    on<GetQstPaper>(_getQstPaper);
    on<ChangeSearch>(_changeSearch);
    on<PressFilter>(_pressFilter);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteQuestion>(_deleteQuestion);
    on<PageIncrement>(_pageIncrement);

    add(GetQstPaper());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQstPaper(
      GetQstPaper event, Emitter<QuestionPaperListState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "search": state.searchText,
      "subject_id": state.subjectId,
    };

    final papers = await _apiRepo.get<QuestionPaperList>(
        endpoint: buildUrl(questionPaperListEndPoint, queryParams));

    if (papers != null) {
      emit(state.copyWith(qstPapers: papers));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<QuestionPaperListState> emit) {
    emit(state.copyWith(
      searchText: event.searchText,
      subjectId: event.filterBloc.state.selectedSubjectId,
    ));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetQstPaper());
    });
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<QuestionPaperListState> emit) {
    emit(state.copyWith(subjectId: event.filterBloc.state.selectedSubjectId));
    add(GetQstPaper());
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<QuestionPaperListState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteQuestion(qId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(questionPaperCreateScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteQuestion(
      DeleteQuestion event, Emitter<QuestionPaperListState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: questionPaperDtlsEndPoint(qId: event.qId),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          questionPaperListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<QuestionPaperListState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.qstPapers.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "search": state.searchText,
          "subject_id": state.searchText,
        };

        final pagiQuestion = await _apiRepo.get<QuestionPaperList>(
          endpoint: buildUrl(questionPaperListEndPoint, queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (pagiQuestion != null) {
          emit(state.copyWith(
              qstPapers: QuestionPaperList(
            data: state.qstPapers.data! + pagiQuestion.data!,
            lastPage: pagiQuestion.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
