import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_student_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'quiz_finish_event.dart';
part 'quiz_finish_state.dart';

class QuizFinishBloc extends Bloc<QuizFinishEvent, QuizFinishState> {
  QuizFinishBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuizFinishInitial()) {
    on<GetIdForQuizDtls>(_getIdForQuizDtls);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getIdForQuizDtls(
      GetIdForQuizDtls event, Emitter<QuizFinishState> emit) async {
    final details = await _apiRepo.get<QuizDetailsForStudent>(
        endpoint: studentQuizDtlsEndPoint(
      sId: _localStorageRepo.read(key: loginIdDB)!,
      quizId: event.quizId,
    ));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
