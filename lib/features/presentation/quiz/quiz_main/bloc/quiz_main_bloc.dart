import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_student_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'quiz_main_event.dart';
part 'quiz_main_state.dart';

class QuizMainBloc extends Bloc<QuizMainEvent, QuizMainState> {
  Timer? _quizTimer;

  QuizMainBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuizMainInitial()) {
    on<GetQuizIdForStart>(_getQuizIdForStart);
    on<StartQuiz>(_startQuiz);
    on<UpdateTime>(_updateTime);
    on<StopTimer>(_stopTimer);
    on<PressToNext>(_pressToNext);
    on<PressToPrev>(_pressToPrev);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQuizIdForStart(
      GetQuizIdForStart event, Emitter<QuizMainState> emit) async {
    final details = await _apiRepo.get<QuizDetailsForStudent>(
        endpoint: studentQuizDtlsEndPoint(
      sId: _localStorageRepo.read(key: loginIdDB)!,
      quizId: event.quizId,
    ));

    if (details != null) {
      emit(state.copyWith(
          details: details, totalTimeInSec: (details.data!.duration! * 60)));

      add(StartQuiz());
    }
  }

  FutureOr<void> _startQuiz(StartQuiz event, Emitter<QuizMainState> emit) {
    int secondCounter = state.totalTimeInSec;

    _quizTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondCounter -= 1;
      final minutes = (secondCounter ~/ 60).toString().padLeft(2, '0');
      final seconds = (secondCounter % 60).toString().padLeft(2, '0');
      // final formattedTime = "$minutes:$seconds";

      add((UpdateTime(
          min: minutes, sec: seconds, secondCounter: secondCounter)));

      if (secondCounter <= 0) {
        timer.cancel();
        _quizTimer = null;
      }
    });
  }

  FutureOr<void> _updateTime(UpdateTime event, Emitter<QuizMainState> emit) {
    emit(state.copyWith(
      min: event.min,
      sec: event.sec,
      percentage: event.secondCounter / state.totalTimeInSec,
    ));
  }

  FutureOr<void> _stopTimer(StopTimer event, Emitter<QuizMainState> emit) {
    _quizTimer?.cancel();
    _quizTimer = null;
  }

  FutureOr<void> _pressToNext(PressToNext event, Emitter<QuizMainState> emit) {
    if ((state.details.data!.totalQuestion! - 1) > state.qstIndex) {
      emit(state.copyWith(qstIndex: state.qstIndex + 1));
    }
  }

  FutureOr<void> _pressToPrev(PressToPrev event, Emitter<QuizMainState> emit) {
    if (state.qstIndex > 0) {
      emit(state.copyWith(qstIndex: state.qstIndex - 1));
    }
  }
}
