part of 'student_dashboard_bloc.dart';

sealed class StudentDashboardEvent extends Equatable {
  const StudentDashboardEvent();

  @override
  List<Object> get props => [];
}

class GetOpenClose extends StudentDashboardEvent {
  const GetOpenClose({required this.isOPen});
  final bool isOPen;
}

class PanelControlOnClick extends StudentDashboardEvent {
  const PanelControlOnClick({required this.panelController});
  final PanelController panelController;
}

class GetUserType extends StudentDashboardEvent {}
