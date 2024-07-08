part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.loading = false,
    this.isObscureText = true,
    this.forms = Forms.initial,
    this.userName = '',
    this.password = '',
  });

  final Forms forms;
  final bool loading;
  final bool isObscureText;
  final String userName;
  final String password;

  LoginState copyWith({
    bool? isObscureText,
    bool? loading,
    String? userName,
    String? password,
    Forms? forms,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      forms: forms ?? this.forms,
      isObscureText: isObscureText ?? this.isObscureText,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [isObscureText, loading, userName, password, forms];
}

final class LoginInitial extends LoginState {}
