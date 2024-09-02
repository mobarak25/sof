import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/profile_attendance_response.dart';
import 'package:school_of_future/features/domain/entities/student_profile_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc
    extends Bloc<StudentProfileEvent, StudentProfileState> {
  StudentProfileBloc(this._apiRepo, this._localStorageRepo)
      : super(StudentProfileInitial()) {
    on<GetStudentProfile>(_getStudentProfile);
    on<GetProfileAttendance>(_getProfileAttendance);

    add(GetStudentProfile());
    add(GetProfileAttendance());
  }

  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getStudentProfile(
      GetStudentProfile event, Emitter<StudentProfileState> emit) async {
    final profileFromDB = await _localStorageRepo
        .readModel<StudentProfileResponse>(key: profileDB);

    if (profileFromDB != null) {
      emit(state.copyWith(profile: profileFromDB));
    }

    // final profileResponse = await _apiRepo.get<StudentProfileResponse>(
    //   endpoint:
    //       studentProfileEndPoint(sId: _localStorageRepo.read(key: loginIdDB)!),
    // );

    // if (profileResponse != null) {
    //   emit(state.copyWith(profile: profileResponse));

    //   await _localStorageRepo.writeModel(
    //       key: profileDB, value: profileResponse);
    // }
  }

  FutureOr<void> _getProfileAttendance(
      GetProfileAttendance event, Emitter<StudentProfileState> emit) async {
    final attendanceFromDB = await _localStorageRepo
        .readModel<ProfileAttendanceResponse>(key: profileAttendanceDB);

    if (attendanceFromDB != null) {
      emit(state.copyWith(attendance: attendanceFromDB));
    }

    final attendance = await _apiRepo.get<ProfileAttendanceResponse>(
        endpoint: profileAttendanceEndPoint(
            sId: _localStorageRepo.read(key: loginIdDB)!));
    if (attendance != null) {
      emit(state.copyWith(attendance: attendance));

      await _localStorageRepo.writeModel(
          key: profileAttendanceDB, value: attendance);
    }
  }
}
