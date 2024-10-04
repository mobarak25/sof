import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/full_syllabus_teacher_response.dart';
import 'package:school_of_future/features/domain/entities/syllabus_teacher_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'teacher_syllabus_list_event.dart';
part 'teacher_syllabus_list_state.dart';

class TeacherSyllabusListBloc
    extends Bloc<TeacherSyllabusListEvent, TeacherSyllabusListState> {
  TeacherSyllabusListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TeacherSyllabusListInitial()) {
    on<DataForTab>(_dataForTab);

    add(DataForTab(tabIndex: state.activeTab));
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<TeacherSyllabusListState> emit) async {
    emit(state.copyWith(
        activeTab: event.tabIndex, page: 1, loading: true, isEndList: false));

    if (state.activeTab == '0') {
      final fullSyllabus = await _apiRepo.get<FullSyllabusTeacher>(
          endpoint: teacherFullSyllabusListEndPoint);

      if (fullSyllabus != null) {
        emit(state.copyWith(teacherFullSyllabus: fullSyllabus));
      }
    }

    emit(state.copyWith(loading: false));
  }
}
