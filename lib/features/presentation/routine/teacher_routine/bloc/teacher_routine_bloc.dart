import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/routine_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';

part 'teacher_routine_event.dart';
part 'teacher_routine_state.dart';

class TeacherRoutineBloc
    extends Bloc<TeacherRoutineEvent, TeacherRoutineState> {
  TeacherRoutineBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherRoutineInitial()) {
    on<IsTeacher>(_isTeacher);
    on<GetDate>(_getDate);
    on<GetRoutine>(_getRoutine);
    on<PageIncrement>(_pageIncrement);

    add(IsTeacher());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  FutureOr<void> _isTeacher(
      IsTeacher event, Emitter<TeacherRoutineState> emit) async {
    emit(state.copyWith(
        isTeacher:
            await LocalData.isTeacher(localStorageRepo: _localStorageRepo)));

    add(GetRoutine());
  }

  FutureOr<void> _getRoutine(
      GetRoutine event, Emitter<TeacherRoutineState> emit) async {
    emit(state.copyWith(loading: true, page: 1, isEndList: false));
    final queryParams = {
      'page': state.page,
      'date': state.date,
    };

    final routine = await _apiRepo.get<Routine>(
      endpoint: state.isTeacher
          ? buildUrl(teacherRoutineEndPoint, queryParams)
          : buildUrl(
              studentRoutineEndPoint(
                  sId: _localStorageRepo.read(key: loginIdDB)!),
              queryParams),
    );

    if (routine != null) {
      emit(state.copyWith(routine: routine, loading: false));
    }
  }

  FutureOr<void> _getDate(GetDate event, Emitter<TeacherRoutineState> emit) {
    final String date =
        getDate(value: event.date.toString(), formate: "yyyy-MM-dd");
    emit(state.copyWith(date: date));

    add(GetRoutine());
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<TeacherRoutineState> emit) async {
    int totalPage = state.page + 1;

    if (totalPage <= state.routine.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          'date': state.date,
        };

        final pagiRoutine = await _apiRepo.get<Routine>(
          endpoint: state.isTeacher
              ? buildUrl(teacherRoutineEndPoint, queryParams)
              : buildUrl(
                  studentRoutineEndPoint(
                      sId: _localStorageRepo.read(key: loginIdDB)!),
                  queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (pagiRoutine != null) {
          emit(state.copyWith(
              routine: Routine(
            data: state.routine.data! + pagiRoutine.data!,
            lastPage: pagiRoutine.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
