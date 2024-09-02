part of 'student_dashboard_bloc.dart';

class StudentDashboardState extends Equatable {
  const StudentDashboardState({
    this.panelIsOpen = false,
    this.isTeacher = false,
  });

  final bool panelIsOpen;
  final bool isTeacher;

  StudentDashboardState copyWith({
    bool? panelIsOpen,
    bool? isTeacher,
  }) {
    return StudentDashboardState(
      panelIsOpen: panelIsOpen ?? this.panelIsOpen,
      isTeacher: isTeacher ?? this.isTeacher,
    );
  }

  @override
  List<Object> get props => [panelIsOpen, isTeacher];
}

final class StudentDashboardInitial extends StudentDashboardState {}
