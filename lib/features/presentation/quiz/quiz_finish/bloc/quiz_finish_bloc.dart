import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'quiz_finish_event.dart';
part 'quiz_finish_state.dart';

class QuizFinishBloc extends Bloc<QuizFinishEvent, QuizFinishState> {
  QuizFinishBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuizFinishInitial()) {
    on<QuizFinishEvent>(fsdf);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> fsdf(QuizFinishEvent event, Emitter<QuizFinishState> emit) {}
}
