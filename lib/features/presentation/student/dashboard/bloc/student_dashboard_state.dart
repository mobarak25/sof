part of 'student_dashboard_bloc.dart';

class StudentDashboardState extends Equatable {
  const StudentDashboardState({
    this.panelIsOpen = false,
  });

  final bool panelIsOpen;

  StudentDashboardState copyWith({bool? panelIsOpen}) {
    return StudentDashboardState(panelIsOpen: panelIsOpen ?? this.panelIsOpen);
  }

  @override
  List<Object> get props => [panelIsOpen];
}

final class StudentDashboardInitial extends StudentDashboardState {}
