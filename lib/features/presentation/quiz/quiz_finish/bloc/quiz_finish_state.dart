part of 'quiz_finish_bloc.dart';

class QuizFinishState extends Equatable {
  const QuizFinishState({
    this.details = const QuizDetailsForStudent(),
  });

  final QuizDetailsForStudent details;

  QuizFinishState copyWith({QuizDetailsForStudent? details}) {
    return QuizFinishState(details: details ?? this.details);
  }

  @override
  List<Object> get props => [details];
}

final class QuizFinishInitial extends QuizFinishState {}
