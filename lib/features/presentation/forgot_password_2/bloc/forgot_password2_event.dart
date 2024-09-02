part of 'forgot_password2_bloc.dart';

sealed class ForgotPassword2Event extends Equatable {
  const ForgotPassword2Event();

  @override
  List<Object> get props => [];
}

class ChangeOtp extends ForgotPassword2Event {
  const ChangeOtp({required this.otp});
  final String otp;
}

class ChangeUsername extends ForgotPassword2Event {
  const ChangeUsername({required this.username});
  final String username;
}

class ChangeNewPassword extends ForgotPassword2Event {
  const ChangeNewPassword({required this.newPassword});
  final String newPassword;
}

class ChangeConfirmePassword extends ForgotPassword2Event {
  const ChangeConfirmePassword({required this.confirmePassword});
  final String confirmePassword;
}

class ChangeisObscureTextNP extends ForgotPassword2Event {}

class ChangeisObscureTextCP extends ForgotPassword2Event {}

class PressToSend extends ForgotPassword2Event {
  const PressToSend(
      {required this.otpFocusNode,
      required this.usernameFocusNode,
      required this.newPasswordFocusNode,
      required this.confirmedPasswordFocusNode});

  final FocusNode otpFocusNode;
  final FocusNode usernameFocusNode;
  final FocusNode newPasswordFocusNode;
  final FocusNode confirmedPasswordFocusNode;
}

class GoToLoginScreen extends ForgotPassword2Event {}
