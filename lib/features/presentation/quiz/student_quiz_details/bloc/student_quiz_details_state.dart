part of 'student_quiz_details_bloc.dart';

sealed class StudentQuizDetailsState extends Equatable {
  const StudentQuizDetailsState();
  
  @override
  List<Object> get props => [];
}

final class StudentQuizDetailsInitial extends StudentQuizDetailsState {}
