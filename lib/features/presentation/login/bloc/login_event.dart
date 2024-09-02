part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class IsObscureText extends LoginEvent {}

class ChangeUserName extends LoginEvent {
  const ChangeUserName({required this.userName});
  final String userName;
}

class ChangePassword extends LoginEvent {
  const ChangePassword({required this.password});
  final String password;
}

class PressToLogin extends LoginEvent {
  const PressToLogin({
    required this.userNameFocusNode,
    required this.passwordFocusNode,
  });
  final FocusNode userNameFocusNode;
  final FocusNode passwordFocusNode;
}

class GetMe extends LoginEvent {}

class GoToDashboard extends LoginEvent {
  const GoToDashboard({required this.userType});
  final int userType;
}

class GoToSelectChild extends LoginEvent {}
