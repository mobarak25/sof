import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/student_full_syllabus_response.dart';
import 'package:school_of_future/features/domain/entities/syllabus_teacher_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'student_syllabus_event.dart';
part 'student_syllabus_state.dart';

class StudentSyllabusBloc
    extends Bloc<StudentSyllabusEvent, StudentSyllabusState> {
  StudentSyllabusBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentSyllabusInitial()) {
    on<DataForTab>(_dataForTab);
    on<PageIncrement>(_pageIncrement);

    add(DataForTab(tabIndex: state.activeTab));
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<StudentSyllabusState> emit) async {
    emit(state.copyWith(
        activeTab: event.tabIndex, page: 1, loading: true, isEndList: false));

    final queryParams = {
      "type": state.activeTab == '1' ? "class-test" : "quiz-test",
      "page": 1,
    };
    final sId = _localStorageRepo.read(key: loginIdDB)!;

    if (state.activeTab == '0') {
      final fullSyllabus = await _apiRepo.get<StudentFullSyllabus>(
        endpoint: studentFullSyllabusEndPoint(sId: sId),
      );

      if (fullSyllabus != null) {
        emit(state.copyWith(studentFullSyllabus: fullSyllabus));
      }
    } else {
      final classQuiz = await _apiRepo.get<SyllabusTeacher>(
        endpoint: buildUrl(
            studentQuizClassTestSyllabusEndPoint(sId: sId), queryParams),
      );

      if (classQuiz != null) {
        emit(state.copyWith(classQuizText: classQuiz));
      }
    }

    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<StudentSyllabusState> emit) async {
    int totalPage = state.page + 1;
    final sId = _localStorageRepo.read(key: loginIdDB)!;

    if (totalPage <= state.classQuizText.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));
        final queryParams = {
          "page": state.page,
          "type": state.activeTab == '1' ? "class-test" : "quiz-test",
        };

        final studentPagiSyllabus = await _apiRepo.get<SyllabusTeacher>(
          endpoint: buildUrl(
              studentQuizClassTestSyllabusEndPoint(sId: sId), queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (studentPagiSyllabus != null) {
          emit(state.copyWith(
              classQuizText: SyllabusTeacher(
            data: state.classQuizText.data! + studentPagiSyllabus.data!,
            lastPage: studentPagiSyllabus.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
