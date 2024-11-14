import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'quiz_main_event.dart';
part 'quiz_main_state.dart';

class QuizMainBloc extends Bloc<QuizMainEvent, QuizMainState> {
  QuizMainBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuizMainInitial()) {
    on<StartQuiz>(_startQuiz);

    add(StartQuiz());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _startQuiz(StartQuiz event, Emitter<QuizMainState> emit) {
    int secondCounter = state.totalTimeInSec;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      secondCounter -= 1;
      // add(IncreaseProgress());
      print(secondCounter);

      if (secondCounter >= 10) {
        // add(NextQuestion());
        timer.cancel();
      }
    });
  }
}
