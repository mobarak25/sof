import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/child_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'select_child_event.dart';
part 'select_child_state.dart';

class SelectChildBloc extends Bloc<SelectChildEvent, SelectChildState> {
  SelectChildBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(SelectChildInitial()) {
    on<GetChilList>(_getChilList);
    on<SelectedId>(_selectedId);
    on<PressToConfirm>(_pressToConfirm);
    add(GetChilList());
  }
  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getChilList(
      GetChilList event, Emitter<SelectChildState> emit) async {
    final childList =
        await _apiRepo.get<ChildListResponse>(endpoint: childListEndPoint);

    if (childList != null) {
      emit(state.copyWith(childList: childList));
    }
  }

  FutureOr<void> _selectedId(
      SelectedId event, Emitter<SelectChildState> emit) async {
    await _localStorageRepo.write(
        key: userIdDB, value: event.userId.toString());

    emit(state.copyWith(selectedId: event.sId));
  }

  FutureOr<void> _pressToConfirm(
      PressToConfirm event, Emitter<SelectChildState> emit) async {
    if (state.selectedId != -1) {
      await _localStorageRepo.write(
          key: loginIdDB, value: state.selectedId.toString());
      //Navigator.popAndPushNamed(_iFlutterNavigator.context, studentDashboard);
      _iFlutterNavigator.popAndPushNamed(studentDashboard);
    } else {
      ShowSnackBar(
        message: "Select One Of Your Child".tr(),
        navigator: _iFlutterNavigator,
        color: kErrorColorSecond,
      );
    }
  }
}
