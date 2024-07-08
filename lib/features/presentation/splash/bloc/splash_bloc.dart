import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/features/data/data_sources/local_keys.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this._iFlutterNavigator, this._localStorageRepo)
      : super(SplashInitial()) {
    on<IsLoggedInCheck>(_isLoggedInCheck);

    add(IsLoggedInCheck());
  }

  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isLoggedInCheck(
      IsLoggedInCheck event, Emitter<SplashState> emit) {
    Timer(const Duration(seconds: 2), () {
      final loginToken = _localStorageRepo.read(key: tokenDB);

      if (loginToken != null) {
        // _iFlutterNavigator.pushReplacement(OnBoardScreen.route());
        print("object=======");
      } else {
        Navigator.popAndPushNamed(_iFlutterNavigator.context, login);

        print("object=======");
      }
      //  _iFlutterNavigator.pushReplacement(HomeScreen.route());
    });
  }
}
