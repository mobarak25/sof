import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'result_summery_event.dart';
part 'result_summery_state.dart';

class ResultSummeryBloc extends Bloc<ResultSummeryEvent, ResultSummeryState> {
  ResultSummeryBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(ResultSummeryInitial()) {
    on<ResultSummeryEvent>(sdf);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> sdf(
      ResultSummeryEvent event, Emitter<ResultSummeryState> emit) {}
}
