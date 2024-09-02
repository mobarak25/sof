import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';

part 'forgot_password2_event.dart';
part 'forgot_password2_state.dart';

class ForgotPassword2Bloc
    extends Bloc<ForgotPassword2Event, ForgotPassword2State> {
  ForgotPassword2Bloc(this._apiRepo, this._iFlutterNavigator)
      : super(ForgotPassword2Initial()) {
    on<ChangeOtp>(_changeOtp);
    on<ChangeUsername>(_changeUsername);
    on<ChangeNewPassword>(_changeNewPassword);
    on<ChangeConfirmePassword>(_changeConfirmePassword);
    on<ChangeisObscureTextNP>(_changeisObscureTextNP);
    on<ChangeisObscureTextCP>(_changeisObscureTextCP);
    on<PressToSend>(_pressToSend);
    on<GoToLoginScreen>(_goToLoginScreen);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _changeOtp(
      ChangeOtp event, Emitter<ForgotPassword2State> emit) {
    emit(state.copyWith(otp: event.otp));
  }

  FutureOr<void> _changeUsername(
      ChangeUsername event, Emitter<ForgotPassword2State> emit) {
    emit(state.copyWith(username: event.username));
  }

  FutureOr<void> _changeNewPassword(
      ChangeNewPassword event, Emitter<ForgotPassword2State> emit) {
    emit(state.copyWith(newPassword: event.newPassword));
  }

  FutureOr<void> _changeConfirmePassword(
      ChangeConfirmePassword event, Emitter<ForgotPassword2State> emit) {
    emit(state.copyWith(confirmePassword: event.confirmePassword));
  }

  FutureOr<void> _goToLoginScreen(
      GoToLoginScreen event, Emitter<ForgotPassword2State> emit) {
    Navigator.pushNamedAndRemoveUntil(
        _iFlutterNavigator.context, login, ModalRoute.withName('/'));
  }

  FutureOr<void> _changeisObscureTextNP(
      ChangeisObscureTextNP event, Emitter<ForgotPassword2State> emit) {
    emit(state.copyWith(isObscureTextNP: !state.isObscureTextNP));
  }

  FutureOr<void> _changeisObscureTextCP(
      ChangeisObscureTextCP event, Emitter<ForgotPassword2State> emit) {
    emit(state.copyWith(isObscureTextCP: !state.isObscureTextCP));
  }

  FutureOr<void> _pressToSend(
      PressToSend event, Emitter<ForgotPassword2State> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final forgotPasswordResponse = await _apiRepo.post<DefaultResponse>(
        endpoint: forgetPasswordStep2EndPoint,
        body: {
          "otp": state.otp,
          "username": state.username,
          "new_password": state.newPassword,
          "password_confirmation": state.confirmePassword,
          "_method": "put",
        },
      );

      if (forgotPasswordResponse != null) {
        ShowSnackBar(
          message: forgotPasswordResponse.message!,
          color: bGreen,
          navigator: _iFlutterNavigator,
        );
        add(GoToLoginScreen());
      }

      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(PressToSend event) {
    final validate = Validator.isValidated(items: [
      FormItem(text: state.otp, focusNode: event.otpFocusNode),
      FormItem(text: state.username, focusNode: event.usernameFocusNode),
      FormItem(text: state.newPassword, focusNode: event.newPasswordFocusNode),
      FormItem(
          text: state.confirmePassword,
          focusNode: event.confirmedPasswordFocusNode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.otp.isEmpty ||
        state.username.isEmpty ||
        state.newPassword.isEmpty ||
        state.confirmePassword.isEmpty) {
      return false;
    }
    return true;
  }
}
