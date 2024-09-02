part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.forms = Forms.initial,
    this.loading = false,
    this.username = '',
  });

  final Forms forms;
  final bool loading;
  final String username;

  ForgotPasswordState copyWith(
      {Forms? forms, bool? loading, String? username}) {
    return ForgotPasswordState(
      forms: forms ?? this.forms,
      loading: loading ?? this.loading,
      username: username ?? this.username,
    );
  }

  @override
  List<Object> get props => [forms, loading, username];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}
