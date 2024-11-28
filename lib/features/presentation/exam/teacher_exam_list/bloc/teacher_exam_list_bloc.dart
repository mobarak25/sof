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
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/exam_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'teacher_exam_list_event.dart';
part 'teacher_exam_list_state.dart';

class TeacherExamListBloc
    extends Bloc<TeacherExamListEvent, TeacherExamListState> {
  TeacherExamListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherExamListInitial()) {
    on<IsTeacher>(_isTeacher);
    on<GetExamList>(_getExamList);
    on<ChangeSearch>(_changeSearch);
    on<PressFilter>(_pressFilter);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteQuestion>(_deleteQuestion);

    on<PageIncrement>(_pageIncrement);

    add(IsTeacher());
    add(GetExamList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isTeacher(
      IsTeacher event, Emitter<TeacherExamListState> emit) async {
    emit(state.copyWith(
        isTeacher:
            await LocalData.isTeacher(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _getExamList(
      GetExamList event, Emitter<TeacherExamListState> emit) async {
    String sId = _localStorageRepo.read(key: loginIdDB)!;
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "search": state.searchText,
      "subject_id": state.subjectId,
    };

    final examList = await _apiRepo.get<ExamList>(
        endpoint: buildUrl(
            state.isTeacher
                ? teacherExamListEndPoint
                : studentExamListEndPoint(sId: sId),
            queryParams));

    if (examList != null) {
      emit(state.copyWith(examList: examList));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<TeacherExamListState> emit) {
    emit(state.copyWith(
      searchText: event.searchText,
      subjectId: event.filterBloc.state.selectedSubjectId,
    ));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetExamList());
    });
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<TeacherExamListState> emit) {
    emit(state.copyWith(subjectId: event.filterBloc.state.selectedSubjectId));
    add(GetExamList());
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<TeacherExamListState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteQuestion(examId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(teacherExamCreateScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteQuestion(
      DeleteQuestion event, Emitter<TeacherExamListState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: teacherExamDtlsEndPoint(examId: event.examId),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          teacherExamListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<TeacherExamListState> emit) async {
    String sId = _localStorageRepo.read(key: loginIdDB)!;
    int totalPage = state.page + 1;

    if (totalPage <= state.examList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "search": state.searchText,
          "subject_id": state.subjectId,
        };

        final pagiExam = await _apiRepo.get<ExamList>(
          endpoint: buildUrl(
              state.isTeacher
                  ? teacherExamListEndPoint
                  : studentExamListEndPoint(sId: sId),
              queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (pagiExam != null) {
          emit(state.copyWith(
              examList: ExamList(
            data: state.examList.data! + pagiExam.data!,
            lastPage: pagiExam.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
