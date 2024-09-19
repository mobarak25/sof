part of 'classwork_list_bloc.dart';

sealed class ClassworkListState extends Equatable {
  const ClassworkListState();
  
  @override
  List<Object> get props => [];
}

final class ClassworkListInitial extends ClassworkListState {}
