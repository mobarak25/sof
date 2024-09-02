import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(this._apiRepo, this._iFlutterNavigator)
      : super(ForgotPasswordInitial()) {
    on<ChangeUsername>(_changeUsername);
    on<PressToOtp>(_pressToOtp);
    on<GoToStep2>(_goToStep2);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _changeUsername(
      ChangeUsername event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(username: event.username));
  }

  FutureOr<void> _pressToOtp(
      PressToOtp event, Emitter<ForgotPasswordState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final otpResponse = await _apiRepo.post<DefaultResponse>(
        endpoint: forgetPasswordStep1EndPoint,
        body: {
          "username": state.username,
          "_method": "put",
        },
      );

      if (otpResponse != null) {
        add(GoToStep2());
      }

      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  FutureOr<void> _goToStep2(
      GoToStep2 event, Emitter<ForgotPasswordState> emit) {
    _iFlutterNavigator.pushReplacementNamed(forgotPasswordStep2);
  }

  bool isValid(PressToOtp event) {
    final validate = Validator.isValidated(items: [
      FormItem(text: state.username, focusNode: event.usernameFocusNode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.username.isEmpty) {
      return false;
    }
    return true;
  }
}
