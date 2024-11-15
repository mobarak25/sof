import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_student_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'student_quiz_details_event.dart';
part 'student_quiz_details_state.dart';

class StudentQuizDetailsBloc
    extends Bloc<StudentQuizDetailsEvent, StudentQuizDetailsState> {
  StudentQuizDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentQuizDetailsInitial()) {
    on<GetQuizIdForDtls>(_getQuizIdForDtls);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQuizIdForDtls(
      GetQuizIdForDtls event, Emitter<StudentQuizDetailsState> emit) async {
    final details = await _apiRepo.get<QuizDetailsForStudent>(
        endpoint: studentQuizDtlsEndPoint(
            sId: _localStorageRepo.read(key: loginIdDB)!,
            quizId: event.quizId));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
