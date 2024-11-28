import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/data/model/exam_mark_entry.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/exam_mark_entry_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'theacher_mark_entry_event.dart';
part 'theacher_mark_entry_state.dart';

class TheacherMarkEntryBloc
    extends Bloc<TheacherMarkEntryEvent, TheacherMarkEntryState> {
  TheacherMarkEntryBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TheacherMarkEntryInitial()) {
    on<SaveMark>(_saveMark);
    on<ExamIdForMarkEntry>(_examIdForMarkEntry);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _examIdForMarkEntry(
      ExamIdForMarkEntry event, Emitter<TheacherMarkEntryState> emit) async {
    final students = await _apiRepo.get<ExamMarkEntry>(
        endpoint: teacherExamMarkEntryEndPoint(examId: event.examId));

    if (students != null) {
      List<ExamMark> examMarks = [];
      for (int i = 0; i < students.data!.length; i++) {
        examMarks.add(ExamMark(
          id: students.data![i].id!,
          focusnode: FocusNode(),
          textEditingController: students.data![i].score != null
              ? TextEditingController(text: students.data![i].score!.mark!)
              : TextEditingController(),
        ));
      }

      emit(state.copyWith(
          students: students, tempExamMark: examMarks, examId: event.examId));
    }
  }

  FutureOr<void> _saveMark(
      SaveMark event, Emitter<TheacherMarkEntryState> emit) async {
    emit(state.copyWith(loading: true));
    final List<MarkHolder> marks = [];
    for (int i = 0; i < state.tempExamMark.length; i++) {
      if (state.tempExamMark[i].textEditingController.text.isNotEmpty) {
        marks.add(MarkHolder(
            studentId: state.tempExamMark[i].id,
            mark: state.tempExamMark[i].textEditingController.text));
      }
    }

    final save = await _apiRepo.post<DefaultResponse>(
      endpoint: teacherExamMarkEntryEndPoint(examId: state.examId),
      body: ExamMarkEntryModal(marks: marks),
    );

    if (save != null) {
      ShowSnackBar(message: save.message!, navigator: _iFlutterNavigator);
      emit(state.copyWith(loading: true));
      Navigator.popUntil(_iFlutterNavigator.context, (route) => route.isFirst);
    }
  }
}
