part of 'quiz_finish_bloc.dart';

sealed class QuizFinishState extends Equatable {
  const QuizFinishState();
  
  @override
  List<Object> get props => [];
}

final class QuizFinishInitial extends QuizFinishState {}
