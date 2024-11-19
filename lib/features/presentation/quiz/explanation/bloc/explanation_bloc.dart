import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_student_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'explanation_event.dart';
part 'explanation_state.dart';

class ExplanationBloc extends Bloc<ExplanationEvent, ExplanationState> {
  ExplanationBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(ExplanationInitial()) {
    on<GetQstIdForExplanation>(_getQstIdForExplanation);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQstIdForExplanation(
      GetQstIdForExplanation event, Emitter<ExplanationState> emit) {
    emit(state.copyWith(qIndex: event.qstIndex, question: event.question));
  }
}
