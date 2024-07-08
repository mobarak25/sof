part of 'student_dashboard_dart_bloc.dart';

sealed class StudentDashboardDartState extends Equatable {
  const StudentDashboardDartState();
  
  @override
  List<Object> get props => [];
}

final class StudentDashboardDartInitial extends StudentDashboardDartState {}
