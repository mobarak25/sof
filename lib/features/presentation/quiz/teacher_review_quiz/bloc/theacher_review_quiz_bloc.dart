import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/data/model/update_short_question_mark.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
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
    on<PressToSave>(_pressToSave);
    on<PressToReset>(_pressToReset);
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
      List<Mark> marks = [];
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
          marks.add(
            Mark(
              questionId: details.data!.questions![i].id!,
              mark: null,
              markingExplaination: '',
            ),
          );
        }
      }
      emit(state.copyWith(
        details: details,
        totalMarks: details.data!.studentTime!.obtainedMark,
        studentInfo: event.studentInfo,
        markController: controllters,
        marks: marks,
      ));
    }
  }

  FutureOr<void> _changeMark(
      ChangeMark event, Emitter<TheacherReviewQuizState> emit) {
    num tempMark = 0;
    num changedMark = event.mark.isNotEmpty ? num.tryParse(event.mark) ?? 0 : 0;
    List<Mark> updateMark = List.from(state.marks);

    for (int i = 0; i < state.marks.length; i++) {
      if (updateMark[i].questionId == event.questionId) {
        updateMark[i] = Mark(
          questionId: state.marks[i].questionId,
          mark: changedMark,
          markingExplaination: '',
        );
      }
    }
    emit(state.copyWith(marks: updateMark));

    for (int i = 0; i < state.marks.length; i++) {
      tempMark += state.marks[i].mark ?? 0;
    }

    emit(state.copyWith(
        totalMarks: state.details.data!.studentTime!.obtainedMark! + tempMark));
  }

  FutureOr<void> _pressToSave(
      PressToSave event, Emitter<TheacherReviewQuizState> emit) async {
    final response = await _apiRepo.post<DefaultResponse>(
      endpoint: updateQuizShortQstMarkEndPoint,
      body: UpdateShortQuestionMark(
        quizId: state.details.data!.id!,
        studentId: state.studentInfo.studentId!,
        marks: state.marks,
      ),
    );

    if (response != null) {
      ShowSnackBar(message: response.message!, navigator: _iFlutterNavigator);
      _iFlutterNavigator.pop(state.details.data!.id!);
    }
  }

  FutureOr<void> _pressToReset(
      PressToReset event, Emitter<TheacherReviewQuizState> emit) async {
    final response = await _apiRepo.post<DefaultResponse>(
      endpoint: resetMarkEndPoint,
      body: {
        "quiz_id": state.details.data!.id!,
        "student_id": [state.studentInfo.studentId!],
        "_method": "PUT",
      },
    );

    if (response != null) {
      ShowSnackBar(message: response.message!, navigator: _iFlutterNavigator);
      _iFlutterNavigator.pop(state.details.data!.id!);
    }
  }
}
