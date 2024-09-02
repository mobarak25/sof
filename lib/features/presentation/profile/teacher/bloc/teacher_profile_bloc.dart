import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/teacher_profile_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_profile_event.dart';
part 'teacher_profile_state.dart';

class TeacherProfileBloc
    extends Bloc<TeacherProfileEvent, TeacherProfileState> {
  TeacherProfileBloc(this._apiRepo, this._localStorageRepo)
      : super(TeacherProfileInitial()) {
    on<GetProfile>(_getProfile);

    add(GetProfile());
  }

  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getProfile(
      GetProfile event, Emitter<TeacherProfileState> emit) async {
    final profile = await _apiRepo.get<TeacherProfileResponse>(
        endpoint: teacherProfileEndPoint);

    if (profile != null) {
      emit(state.copyWith(profile: profile));
    }
  }
}
