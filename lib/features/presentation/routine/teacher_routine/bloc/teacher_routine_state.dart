part of 'teacher_routine_bloc.dart';

sealed class TeacherRoutineState extends Equatable {
  const TeacherRoutineState();
  
  @override
  List<Object> get props => [];
}

final class TeacherRoutineInitial extends TeacherRoutineState {}
