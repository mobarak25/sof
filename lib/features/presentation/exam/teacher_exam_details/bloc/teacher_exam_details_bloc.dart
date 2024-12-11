import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/exam_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';

part 'teacher_exam_details_event.dart';
part 'teacher_exam_details_state.dart';

class TeacherExamDetailsBloc
    extends Bloc<TeacherExamDetailsEvent, TeacherExamDetailsState> {
  TeacherExamDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherExamDetailsInitial()) {
    on<IsTeacher>(_isTeacher);
    on<ExamIdForDtls>(_examIdForDtls);

    add(IsTeacher());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isTeacher(
      IsTeacher event, Emitter<TeacherExamDetailsState> emit) async {
    final isTeacher =
        await LocalData.isTeacher(localStorageRepo: _localStorageRepo);
    emit(state.copyWith(isTeacher: isTeacher));
  }

  FutureOr<void> _examIdForDtls(
      ExamIdForDtls event, Emitter<TeacherExamDetailsState> emit) async {
    final details = await _apiRepo.get<ExamDetails>(
        endpoint: teacherExamDtlsEndPoint(examId: event.examId));

    if (details != null) {
      emit(state.copyWith(examDtls: details));
    }
  }
}
