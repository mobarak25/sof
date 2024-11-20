import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/data/model/answer_quiz.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_student_response.dart';
import 'package:school_of_future/features/domain/entities/track_time_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'quiz_main_event.dart';
part 'quiz_main_state.dart';

class QuizMainBloc extends Bloc<QuizMainEvent, QuizMainState> {
  Timer? _quizTimer;

  QuizMainBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuizMainInitial()) {
    on<GetQuizIdForStart>(_getQuizIdForStart);
    on<GetTrackTime>(_getTrackTime);
    on<StartQuiz>(_startQuiz);
    on<UpdateTime>(_updateTime);
    on<StopTimer>(_stopTimer);
    on<PressToNext>(_pressToNext);
    on<PressToPrev>(_pressToPrev);
    on<PressToOptions>(_pressToOptions);
    on<ChangeExplanation>(_changeExplanation);
    on<PressToFinish>(_pressToFinish);
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
      List<QuizAns> answer = [];
      for (int i = 0; i < details.data!.questions!.length; i++) {
        answer.add(QuizAns(
            questionId: details.data!.questions![i].id!,
            type: details.data!.questions![i].type!,
            answer: '',
            focusnode: FocusNode(),
            textEditingController: TextEditingController()));
      }

      emit(state.copyWith(details: details, quizAns: answer));
      add(GetTrackTime());
    }
  }

  FutureOr<void> _getTrackTime(
      GetTrackTime event, Emitter<QuizMainState> emit) async {
    final getTime = await _apiRepo.post<TrackTime>(
      endpoint: trackTimeEndPoint,
      body: {"quiz_id": state.details.data!.id!, "_method": "PUT"},
    );

    if (getTime != null) {
      emit(state.copyWith(trackTime: getTime, totalTimeInSec: getTime.data));

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

  FutureOr<void> _pressToOptions(
      PressToOptions event, Emitter<QuizMainState> emit) {
    List<QuizAns> updateAns = List.from(state.quizAns);
    updateAns[event.questionIndex] = QuizAns(
      questionId: state.quizAns[event.questionIndex].questionId,
      type: state.quizAns[event.questionIndex].type,
      answer: event.ans,
      focusnode: FocusNode(),
      textEditingController: TextEditingController(),
    );

    emit(state.copyWith(quizAns: updateAns));
  }

  FutureOr<void> _changeExplanation(
      ChangeExplanation event, Emitter<QuizMainState> emit) {}

  FutureOr<void> _pressToFinish(
      PressToFinish event, Emitter<QuizMainState> emit) async {
    emit(state.copyWith(loading: true));
    List<AnswerElement> answers = [];
    for (int i = 0; i < state.quizAns.length; i++) {
      if (state.quizAns[i].type != 3) {
        answers.add(AnswerElement(
          questionId: state.quizAns[i].questionId,
          type: state.quizAns[i].type,
          answer: state.quizAns[i].answer,
        ));
      } else {
        answers.add(AnswerElement(
          questionId: state.quizAns[i].questionId,
          type: state.quizAns[i].type,
          answer: state.quizAns[i].textEditingController.text,
        ));
      }
    }

    final submitAns = await _apiRepo.post<DefaultResponse>(
      endpoint: quizAnsEndPoint,
      body: AnswerQuiz(
        quizId: state.details.data!.id!,
        isFinalSubmit: 1,
        answers: answers,
      ),
    );

    if (submitAns != null) {
      Navigator.of(_iFlutterNavigator.context)
          .popUntil((route) => route.isFirst);

      Navigator.of(navigatorKey.currentState!.context, rootNavigator: true)
          .pushNamed(quizFinishScreen, arguments: state.details.data!.id);

      ShowSnackBar(message: submitAns.message!, navigator: _iFlutterNavigator);
    }
    emit(state.copyWith(loading: false));
  }
}
