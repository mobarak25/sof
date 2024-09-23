import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/widgets/confirm_delete_dialog.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/classwork_details_response.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';

part 'classwork_details_event.dart';
part 'classwork_details_state.dart';

class ClassworkDetailsBloc
    extends Bloc<ClassworkDetailsEvent, ClassworkDetailsState> {
  ClassworkDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(ClassworkDetailsInitial()) {
    on<IsTeacher>(_isTeacher);
    on<GetClassworkDetails>(_getClassworkDetails);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteClasswork>(_deleteClasswork);

    add(IsTeacher());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isTeacher(
      IsTeacher event, Emitter<ClassworkDetailsState> emit) async {
    emit(state.copyWith(
        isTeacher:
            await LocalData.isTeacher(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _getClassworkDetails(
      GetClassworkDetails event, Emitter<ClassworkDetailsState> emit) async {
    final details = await _apiRepo.get<ClassworkDetails>(
        endpoint: classworkDetailsEndPoint(id: event.classworkId));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<ClassworkDetailsState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteClasswork(classworkId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(teacherClassworkCreateSreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteClasswork(
      DeleteClasswork event, Emitter<ClassworkDetailsState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: classworkDetailsEndPoint(
          id: event.classworkId,
        ),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.popUntil((route) => route.isFirst);
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          classworkListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }
}
