import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_attendance_event.dart';
part 'teacher_attendance_state.dart';

class TeacherAttendanceBloc
    extends Bloc<TeacherAttendanceEvent, TeacherAttendanceState> {
  TeacherAttendanceBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherAttendanceInitial()) {
    on<TeacherAttendanceEvent>(fdgdfg);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> fdgdfg(
      TeacherAttendanceEvent event, Emitter<TeacherAttendanceState> emit) {}
}
