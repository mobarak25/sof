part of 'menu_bloc.dart';

class MenuState extends Equatable {
  const MenuState({this.isTeacher = false});

  final bool isTeacher;

  MenuState copyWith({bool? isTeacher}) {
    return MenuState(isTeacher: isTeacher ?? this.isTeacher);
  }

  @override
  List<Object> get props => [isTeacher];
}

final class MenuInitial extends MenuState {}
