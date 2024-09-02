part of 'forgot_password2_bloc.dart';

class ForgotPassword2State extends Equatable {
  const ForgotPassword2State({
    this.forms = Forms.initial,
    this.loading = false,
    this.otp = '',
    this.username = '',
    this.newPassword = '',
    this.confirmePassword = '',
    this.isObscureTextNP = true,
    this.isObscureTextCP = true,
  });

  final Forms forms;
  final bool loading;
  final String otp;
  final String username;
  final String newPassword;
  final String confirmePassword;
  final bool isObscureTextNP;
  final bool isObscureTextCP;

  ForgotPassword2State copyWith({
    Forms? forms,
    bool? loading,
    String? otp,
    String? username,
    String? newPassword,
    String? confirmePassword,
    bool? isObscureTextNP,
    bool? isObscureTextCP,
  }) {
    return ForgotPassword2State(
      forms: forms ?? this.forms,
      loading: loading ?? this.loading,
      otp: otp ?? this.otp,
      username: username ?? this.username,
      newPassword: newPassword ?? this.newPassword,
      confirmePassword: confirmePassword ?? this.confirmePassword,
      isObscureTextNP: isObscureTextNP ?? this.isObscureTextNP,
      isObscureTextCP: isObscureTextCP ?? this.isObscureTextCP,
    );
  }

  @override
  List<Object> get props => [
        forms,
        loading,
        otp,
        username,
        newPassword,
        confirmePassword,
        isObscureTextNP,
        isObscureTextCP,
      ];
}

final class ForgotPassword2Initial extends ForgotPassword2State {}
