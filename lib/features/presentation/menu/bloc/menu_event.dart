part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class LogOut extends MenuEvent {}

class ConfirmedLogout extends MenuEvent {}
