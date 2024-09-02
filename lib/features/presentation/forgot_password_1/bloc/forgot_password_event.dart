part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangeUsername extends ForgotPasswordEvent {
  const ChangeUsername({required this.username});
  final String username;
}

class PressToOtp extends ForgotPasswordEvent {
  const PressToOtp({required this.usernameFocusNode});
  final FocusNode usernameFocusNode;
}

class GoToStep2 extends ForgotPasswordEvent {}
