import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/entity_map/student_full_syllabus_response.dart';
import 'package:school_of_future/features/domain/entities/syllabus_teacher_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'student_syllabus_event.dart';
part 'student_syllabus_state.dart';

class StudentSyllabusBloc
    extends Bloc<StudentSyllabusEvent, StudentSyllabusState> {
  StudentSyllabusBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(StudentSyllabusInitial()) {
    on<DataForTab>(_dataForTab);

    add(DataForTab(tabIndex: state.activeTab));
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<StudentSyllabusState> emit) async {
    emit(state.copyWith(
        activeTab: event.tabIndex, page: 1, loading: true, isEndList: false));

    if (state.activeTab == '0') {
      final fullSyllabus = await _apiRepo.get<StudentFullSyllabus>(
          endpoint: studentFullSyllabusEndPoint(
              sId: _localStorageRepo.read(key: loginIdDB)!));

      if (fullSyllabus != null) {
        emit(state.copyWith(studentFullSyllabus: fullSyllabus));
      }
    }

    emit(state.copyWith(loading: false));
  }
}
