import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_routine_event.dart';
part 'teacher_routine_state.dart';

class TeacherRoutineBloc
    extends Bloc<TeacherRoutineEvent, TeacherRoutineState> {
  TeacherRoutineBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherRoutineInitial()) {
    on<TeacherRoutineEvent>(gf);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> gf(
      TeacherRoutineEvent event, Emitter<TeacherRoutineState> emit) {}
}
