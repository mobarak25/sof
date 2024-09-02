part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.forms = Forms.initial,
    this.loading = false,
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmePassword = '',
  });

  final Forms forms;
  final bool loading;
  final String currentPassword;
  final String newPassword;
  final String confirmePassword;

  ChangePasswordState copyWith({
    Forms? forms,
    bool? loading,
    String? currentPassword,
    String? newPassword,
    String? confirmePassword,
  }) {
    return ChangePasswordState(
      forms: forms ?? this.forms,
      loading: loading ?? this.loading,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmePassword: confirmePassword ?? this.confirmePassword,
    );
  }

  @override
  List<Object> get props => [
        forms,
        loading,
        currentPassword,
        newPassword,
        confirmePassword,
      ];
}

final class ChangePasswordInitial extends ChangePasswordState {}
