part of 'explanation_bloc.dart';

class ExplanationState extends Equatable {
  const ExplanationState({
    this.qIndex = -1,
    this.question = const Question(),
  });

  final int qIndex;
  final Question question;

  ExplanationState copyWith({int? qIndex, Question? question}) {
    return ExplanationState(
      qIndex: qIndex ?? this.qIndex,
      question: question ?? this.question,
    );
  }

  @override
  List<Object> get props => [qIndex, question];
}

final class ExplanationInitial extends ExplanationState {}
