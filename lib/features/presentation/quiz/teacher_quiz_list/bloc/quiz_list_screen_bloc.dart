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
import 'package:school_of_future/features/domain/entities/quiz_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'quiz_list_screen_event.dart';
part 'quiz_list_screen_state.dart';

class QuizListScreenBloc
    extends Bloc<QuizListScreenEvent, QuizListScreenState> {
  QuizListScreenBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuizListScreenInitial()) {
    on<GetQuizList>(_getQuizList);
    on<ChangeSearch>(_changeSearch);
    on<PressFilter>(_pressFilter);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteQuestion>(_deleteQuestion);

    on<PageIncrement>(_pageIncrement);

    add(GetQuizList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQuizList(
      GetQuizList event, Emitter<QuizListScreenState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "search": state.searchText,
      "subject_id": state.subjectId,
    };

    final quizList = await _apiRepo.get<QuizList>(
        endpoint: buildUrl(quizEndPoint, queryParams));

    if (quizList != null) {
      emit(state.copyWith(quizList: quizList));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<QuizListScreenState> emit) {
    emit(state.copyWith(
      searchText: event.searchText,
      subjectId: event.filterBloc.state.selectedSubjectId,
    ));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetQuizList());
    });
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<QuizListScreenState> emit) {
    emit(state.copyWith(subjectId: event.filterBloc.state.selectedSubjectId));
    add(GetQuizList());
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<QuizListScreenState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteQuestion(qId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(quizCreateScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteQuestion(
      DeleteQuestion event, Emitter<QuizListScreenState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: quizDtlsEndPoint(id: event.qId), body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil(quizListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<QuizListScreenState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.quizList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "search": state.searchText,
          "subject_id": state.subjectId,
        };

        final pagiQuiz = await _apiRepo.get<QuizList>(
          endpoint: buildUrl(quizEndPoint, queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (pagiQuiz != null) {
          emit(state.copyWith(
              quizList: QuizList(
            data: state.quizList.data! + pagiQuiz.data!,
            lastPage: pagiQuiz.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
