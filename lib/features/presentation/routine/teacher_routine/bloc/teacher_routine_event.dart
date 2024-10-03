part of 'teacher_routine_bloc.dart';

sealed class TeacherRoutineEvent extends Equatable {
  const TeacherRoutineEvent();

  @override
  List<Object> get props => [];
}

class IsTeacher extends TeacherRoutineEvent {}

class GetDate extends TeacherRoutineEvent {
  const GetDate({required this.date});
  final DateTime date;
}

class GetRoutine extends TeacherRoutineEvent {}

class PageIncrement extends TeacherRoutineEvent {}
