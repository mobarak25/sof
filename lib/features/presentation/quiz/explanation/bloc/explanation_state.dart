part of 'explanation_bloc.dart';

sealed class ExplanationState extends Equatable {
  const ExplanationState();
  
  @override
  List<Object> get props => [];
}

final class ExplanationInitial extends ExplanationState {}
