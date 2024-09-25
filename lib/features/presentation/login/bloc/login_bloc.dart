import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/data/model/login.dart';
import 'package:school_of_future/features/domain/entities/login_response.dart';
import 'package:school_of_future/features/domain/entities/me_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._iFlutterNavigator, this._apiRepo, this._localStorageRepo)
      : super(LoginInitial()) {
    on<IsObscureText>(_isObscureText);
    on<ChangeUserName>(_changeUserName);
    on<ChangePassword>(_changePassword);
    on<PressToLogin>(_pressToLogin);
    on<GetMe>(_getMe);
    on<GoToSelectChild>(_goToSelectChild);
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
        body: Login(username: state.userName, password: state.password),
      );
      if (loginResponse != null) {
        await _localStorageRepo.write(
            key: tokenDB, value: loginResponse.accessToken!);

        add(GetMe());
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  FutureOr<void> _getMe(GetMe event, Emitter<LoginState> emit) async {
    /*
      Here Note:
      user_ype = 2 as a teacher;
      user_ype = 3 as a student;
      user_ype = 4 as a parent;
    */
    final meResponse = await _apiRepo.get<MeResponse>(endpoint: meEndPoint);
    if (meResponse != null) {
      await _localStorageRepo.write(
          key: userTypeDB, value: meResponse.userType.toString());

      if (meResponse.student != null) {
        await _localStorageRepo.write(
            key: loginIdDB, value: meResponse.student!.id!.toString());
      }
      if (meResponse.employee != null) {
        await _localStorageRepo.write(
            key: loginIdDB, value: meResponse.employee!.id!.toString());
      }
      //get profile data=========

      if (meResponse.userType == 3) {
        // Navigator.pushReplacementNamed(
        //     _iFlutterNavigator.context, studentDashboard);
        _iFlutterNavigator.pushReplacementNamed(studentDashboard);
      } else if (meResponse.userType == 4) {
        add(GoToSelectChild());
      } else if (meResponse.userType == 2) {
        _iFlutterNavigator.pushReplacementNamed(studentDashboard);
      }
    }
  }

  FutureOr<void> _goToSelectChild(
      GoToSelectChild event, Emitter<LoginState> emit) {
    _iFlutterNavigator.pushReplacementNamed(selectChild);
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
