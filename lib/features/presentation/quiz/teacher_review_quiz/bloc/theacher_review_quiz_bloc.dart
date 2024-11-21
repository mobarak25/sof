import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_student_response.dart';
import 'package:school_of_future/features/domain/entities/quiz_students_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'theacher_review_quiz_event.dart';
part 'theacher_review_quiz_state.dart';

class TheacherReviewQuizBloc
    extends Bloc<TheacherReviewQuizEvent, TheacherReviewQuizState> {
  TheacherReviewQuizBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TheacherReviewQuizInitial()) {
    on<GetDtlsForReview>(_getDtlsForReview);
    on<ChangeMark>(_changeMark);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getDtlsForReview(
      GetDtlsForReview event, Emitter<TheacherReviewQuizState> emit) async {
    final details = await _apiRepo.get<QuizDetailsForStudent>(
        endpoint: studentQuizDtlsEndPoint(
            sId: event.studentInfo.studentId.toString(), quizId: event.id));

    if (details != null) {
      List<MCQOptions> controllters = [];
      for (int i = 0; i < details.data!.questions!.length; i++) {
        if (details.data!.questions![i].type != 3) {
          controllters.add(MCQOptions(
              textEditingController: TextEditingController(
                  text: details.data!.questions![i].pivot!.mark.toString()),
              focusnode: FocusNode()));
        } else {
          controllters.add(MCQOptions(
              textEditingController: TextEditingController(),
              focusnode: FocusNode()));
        }
      }
      emit(state.copyWith(
          details: details,
          totalMarks: details.data!.studentTime!.obtainedMark,
          studentInfo: event.studentInfo,
          markController: controllters));
    }
  }

  FutureOr<void> _changeMark(
      ChangeMark event, Emitter<TheacherReviewQuizState> emit) {
    emit(state.copyWith(totalMarks: state.totalMarks + num.parse(event.mark)));
  }
}
