import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(this._apiRepo, this._iFlutterNavigator)
      : super(ChangePasswordInitial()) {
    on<ChangeCurrentPassword>(_changeCurrentPassword);
    on<ChangeNewPassword>(_changeNewPassword);
    on<ChangeConfirmPassword>(_changeConfirmPassword);
    on<PressToChangePassword>(_pressToChangePassword);
  }
  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _changeCurrentPassword(
      ChangeCurrentPassword event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(currentPassword: event.currentPassword));
  }

  FutureOr<void> _changeNewPassword(
      ChangeNewPassword event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(newPassword: event.newPassword));
  }

  FutureOr<void> _changeConfirmPassword(
      ChangeConfirmPassword event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(confirmePassword: event.confirmPassword));
  }

  FutureOr<void> _pressToChangePassword(
      PressToChangePassword event, Emitter<ChangePasswordState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));
      final changePasswordResponse = await _apiRepo.post<DefaultResponse>(
        endpoint: resetPasswordEndPoint,
        body: {
          "password": state.currentPassword,
          "new_password": state.newPassword,
          "password_confirmation": state.confirmePassword,
          "_method": "put",
        },
      );
      if (changePasswordResponse != null) {
        ShowSnackBar(
          message: changePasswordResponse.message!,
          navigator: _iFlutterNavigator,
          color: bGreen,
        );
        _iFlutterNavigator.pop();
      }
      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(PressToChangePassword event) {
    final validate = Validator.isValidated(items: [
      FormItem(text: state.currentPassword, focusNode: event.currentPassword),
      FormItem(text: state.newPassword, focusNode: event.newPassword),
      FormItem(text: state.confirmePassword, focusNode: event.confirmPassword),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.currentPassword.isEmpty ||
        state.newPassword.isEmpty ||
        state.confirmePassword.isEmpty) {
      return false;
    }
    return true;
  }
}
