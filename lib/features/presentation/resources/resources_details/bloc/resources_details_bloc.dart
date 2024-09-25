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
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/resource_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';

part 'resources_details_event.dart';
part 'resources_details_state.dart';

class ResourcesDetailsBloc
    extends Bloc<ResourcesDetailsEvent, ResourcesDetailsState> {
  ResourcesDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(ResourcesDetailsInitial()) {
    on<GetResourceDetails>(_getResourceDetails);
    on<IsTeacher>(_isTeacher);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteResource>(_deleteResource);

    add(IsTeacher());
  }
  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isTeacher(
      IsTeacher event, Emitter<ResourcesDetailsState> emit) async {
    emit(state.copyWith(
        isTeacher:
            await LocalData.isTeacher(localStorageRepo: _localStorageRepo)));
  }

  FutureOr<void> _getResourceDetails(
      GetResourceDetails event, Emitter<ResourcesDetailsState> emit) async {
    final details = await _apiRepo.get<ResourceDetails>(
        endpoint:
            teacherResourcedetailsEndPoint(resourceId: event.resourcesId));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<ResourcesDetailsState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteResource(resourceId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(teacherResourcesCreateScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteResource(
      DeleteResource event, Emitter<ResourcesDetailsState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: teacherResourcedetailsEndPoint(
          resourceId: event.resourceId,
        ),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.popUntil((route) => route.isFirst);
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          teacherResourcesListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }
}
