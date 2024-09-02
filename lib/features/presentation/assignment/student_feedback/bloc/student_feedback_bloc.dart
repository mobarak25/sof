import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/assignment_feedback_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'student_feedback_event.dart';
part 'student_feedback_state.dart';

class StudentFeedbackBloc
    extends Bloc<StudentFeedbackEvent, StudentFeedbackState> {
  StudentFeedbackBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentFeedbackInitial()) {
    on<GetFeedback>(_getFeedback);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getFeedback(
      GetFeedback event, Emitter<StudentFeedbackState> emit) async {
    print(event.id);

    final feedback = await _apiRepo.get<AssignmentFeedback>(
        endpoint: assignmentFeedbackEndPoint(submitId: event.id));

    if (feedback != null) {
      emit(state.copyWith(feedback: feedback));
    }
  }
}
