import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/login/view/login_screen.dart';
import 'package:school_of_future/features/presentation/menu/widgets/logout_confirmed_alart.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(MenuInitial()) {
    on<LogOut>(_logOut);
    on<ConfirmedLogout>(_confirmedLogout);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _logOut(LogOut event, Emitter<MenuState> emit) {
    showConfirmedDialog(_iFlutterNavigator.context, pressToYes: () {
      add(ConfirmedLogout());
    });
  }

  FutureOr<void> _confirmedLogout(
      ConfirmedLogout event, Emitter<MenuState> emit) {
    _localStorageRepo.removeAll();
    Navigator.of(_iFlutterNavigator.context)
        .pushNamedAndRemoveUntil(login, (Route<dynamic> route) => false);
  }
}
