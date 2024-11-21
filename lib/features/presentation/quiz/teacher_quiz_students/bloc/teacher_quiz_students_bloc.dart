import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_teacher_response.dart';
import 'package:school_of_future/features/domain/entities/quiz_students_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_quiz_students_event.dart';
part 'teacher_quiz_students_state.dart';

class TeacherQuizStudentsBloc
    extends Bloc<TeacherQuizStudentsEvent, TeacherQuizStudentsState> {
  TeacherQuizStudentsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherQuizStudentsInitial()) {
    on<GetQuizIdForStudents>(_getQuizIdForStudents);
    on<PageIncrement>(_pageIncrement);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQuizIdForStudents(GetQuizIdForStudents event,
      Emitter<TeacherQuizStudentsState> emit) async {
    final details = await _apiRepo.get<QuizDetailsForTeacher>(
      endpoint: quizDtlsEndPoint(id: event.quizId),
    );

    final students = await _apiRepo.get<QuizStudents>(
        endpoint: buildUrl(
            quizStudentEndPoint(quizId: event.quizId), {"page": state.page}));

    if (students != null) {
      emit(state.copyWith(
          quizDtls: details, students: students, quizId: event.quizId));
    }
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<TeacherQuizStudentsState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.students.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final pagiStudents = await _apiRepo.get<QuizStudents>(
            endpoint: buildUrl(quizStudentEndPoint(quizId: state.quizId),
                {"page": state.page}));

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (pagiStudents != null) {
          emit(state.copyWith(
              students: QuizStudents(
            data: state.students.data! + pagiStudents.data!,
            lastPage: pagiStudents.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
