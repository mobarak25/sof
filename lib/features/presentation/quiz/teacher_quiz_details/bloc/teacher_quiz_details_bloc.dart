import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_teacher_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_quiz_details_event.dart';
part 'teacher_quiz_details_state.dart';

class TeacherQuizDetailsBloc
    extends Bloc<TeacherQuizDetailsEvent, TeacherQuizDetailsState> {
  TeacherQuizDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherQuizDetailsInitial()) {
    on<TeacherGetQuizIdForDtls>(_teacherGetQuizIdForDtls);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _teacherGetQuizIdForDtls(TeacherGetQuizIdForDtls event,
      Emitter<TeacherQuizDetailsState> emit) async {
    final details = await _apiRepo.get<QuizDetailsForTeacher>(
      endpoint: quizDtlsEndPoint(id: event.quizId),
    );

    if (details != null) {
      emit(state.copyWith(quizDtls: details));
    }
  }
}
