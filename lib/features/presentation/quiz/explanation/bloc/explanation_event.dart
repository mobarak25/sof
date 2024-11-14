part of 'explanation_bloc.dart';

sealed class ExplanationEvent extends Equatable {
  const ExplanationEvent();

  @override
  List<Object> get props => [];
}

class GetQstIdForExplanation extends ExplanationEvent {
  const GetQstIdForExplanation({required this.qstId});
  final int qstId;
}
