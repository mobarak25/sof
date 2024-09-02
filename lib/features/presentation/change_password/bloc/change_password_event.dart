part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangeCurrentPassword extends ChangePasswordEvent {
  const ChangeCurrentPassword({required this.currentPassword});
  final String currentPassword;
}

class ChangeNewPassword extends ChangePasswordEvent {
  const ChangeNewPassword({required this.newPassword});
  final String newPassword;
}

class ChangeConfirmPassword extends ChangePasswordEvent {
  const ChangeConfirmPassword({required this.confirmPassword});
  final String confirmPassword;
}

class PressToChangePassword extends ChangePasswordEvent {
  const PressToChangePassword(
      {required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword});
  final FocusNode currentPassword;
  final FocusNode newPassword;
  final FocusNode confirmPassword;
}
