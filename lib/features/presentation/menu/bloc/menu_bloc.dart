import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/menu/widgets/language_modal.dart';
import 'package:school_of_future/features/presentation/menu/widgets/logout_confirmed_alart.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(MenuInitial()) {
    on<LogOut>(_logOut);
    on<ConfirmedLogout>(_confirmedLogout);
    on<ChangeLanguage>(_changeLanguage);
    on<UserType>(_userType);

    add(UserType());
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

  FutureOr<void> _changeLanguage(
      ChangeLanguage event, Emitter<MenuState> emit) {
    labguageModal(event.context, pressToYes: () {}, pressToEn: () {
      event.context.setLocale(const Locale('en', 'US'));
    }, pressToBD: () {
      event.context.setLocale(const Locale('bn', 'BD'));
    });
  }

  FutureOr<void> _userType(UserType event, Emitter<MenuState> emit) async {
    final usertype = _localStorageRepo.read(key: userTypeDB);
    if (usertype == '2') {
      emit(state.copyWith(isTeacher: true));
    }
  }
}
