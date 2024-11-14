import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/debounce.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/quiz_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'student_quiz_list_event.dart';
part 'student_quiz_list_state.dart';

class StudentQuizListBloc
    extends Bloc<StudentQuizListEvent, StudentQuizListState> {
  StudentQuizListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentQuizListInitial()) {
    on<GetQuizList>(_getQuizList);
    on<ChangeSearch>(_changeSearch);
    on<PressFilter>(_pressFilter);
    on<PageIncrement>(_pageIncrement);

    add(GetQuizList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQuizList(
      GetQuizList event, Emitter<StudentQuizListState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "search": state.searchText,
      "start_date": state.startDate,
      "end_date": state.endDate,
      "subject_id": state.subjectId,
    };

    final quizList = await _apiRepo.get<QuizList>(
        endpoint: buildUrl(
            studentQuizListEndPoint(
                sId: _localStorageRepo.read(key: loginIdDB)!),
            queryParams));

    if (quizList != null) {
      emit(state.copyWith(quizList: quizList));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<StudentQuizListState> emit) {
    emit(state.copyWith(
      searchText: event.searchText,
      subjectId: event.filterBloc.state.selectedSubjectId,
      startDate: event.filterBloc.state.startDate,
      endDate: event.filterBloc.state.endDate,
    ));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetQuizList());
    });
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<StudentQuizListState> emit) {
    emit(state.copyWith(
      subjectId: event.filterBloc.state.selectedSubjectId,
      startDate: event.filterBloc.state.startDate,
      endDate: event.filterBloc.state.endDate,
    ));
    add(GetQuizList());
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<StudentQuizListState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.quizList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "search": state.searchText,
          "start_date": state.startDate,
          "end_date": state.endDate,
          "subject_id": state.subjectId,
        };

        final pagiQuiz = await _apiRepo.get<QuizList>(
          endpoint: buildUrl(
              studentQuizListEndPoint(
                  sId: _localStorageRepo.read(key: loginIdDB)!),
              queryParams),
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
