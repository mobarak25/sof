import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/confirm_delete_dialog.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/syllabus_teacher_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'syllabus_class_quiz_event.dart';
part 'syllabus_class_quiz_state.dart';

class SyllabusClassQuizBloc
    extends Bloc<SyllabusClassQuizEvent, SyllabusClassQuizState> {
  SyllabusClassQuizBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(SyllabusClassQuizInitial()) {
    on<GetList>(_getList);
    on<PressToDelete>(_pressToDelete);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getList(
      GetList event, Emitter<SyllabusClassQuizState> emit) async {
    event.queryParams["page"] = 1;
    emit(state.copyWith(queryParams: event.queryParams, loading: true));
    final syllabus = await _apiRepo.get<SyllabusTeacher>(
        endpoint: buildUrl(teacherSyllabusListEndPoint, state.queryParams));

    if (syllabus != null) {
      emit(state.copyWith(classQuizTest: syllabus, loading: false));
    }
  }

  FutureOr<void> _pressToDelete(
      PressToDelete event, Emitter<SyllabusClassQuizState> emit) {
    showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () async {
      final delete = await _apiRepo.post<DefaultResponse>(
          endpoint: syllabusDetailsEndPoint(syllabusId: event.id),
          body: {"_method": "delete"});

      if (delete != null) {
        _iFlutterNavigator.pop();
        add(GetList(queryParams: state.queryParams));
        ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
      }
    });
  }
}
