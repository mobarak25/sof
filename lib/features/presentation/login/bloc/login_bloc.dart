import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/features/data/data_sources/local_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/data/model/login.dart';
import 'package:school_of_future/features/domain/entities/login_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(LoginInitial()) {
    on<IsObscureText>(_isObscureText);
    on<ChangeUserName>(_changeUserName);
    on<ChangePassword>(_changePassword);
    on<PressToLogin>(_pressToLogin);
  }

  final IFlutterNavigator _iFlutterNavigator;
  final ApiRepo _apiRepo;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isObscureText(IsObscureText event, Emitter<LoginState> emit) {
    emit(state.copyWith(isObscureText: !state.isObscureText));
  }

  FutureOr<void> _changeUserName(
      ChangeUserName event, Emitter<LoginState> emit) {
    emit(state.copyWith(userName: event.userName));
  }

  FutureOr<void> _changePassword(
      ChangePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _pressToLogin(
      PressToLogin event, Emitter<LoginState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final loginResponse = await _apiRepo.post<LoginResponse>(
        endpoint: loginEndPoint,
        body: Login(
          username: state.userName,
          password: state.password,
        ),
      );
      if (loginResponse != null) {
        //  _iFlutterNavigator.pushReplacement(OnBoardScreen.route());
        await _localStorageRepo.write(
            key: tokenDB, value: loginResponse.accessToken!);
        print(loginResponse.accessToken);
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(PressToLogin event) {
    final validate = Validator.isValidated(items: [
      FormItem(text: state.userName, focusNode: event.userNameFocusNode),
      FormItem(text: state.password, focusNode: event.passwordFocusNode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.userName.isEmpty || state.password.isEmpty) {
      return false;
    }
    return true;
  }
}
