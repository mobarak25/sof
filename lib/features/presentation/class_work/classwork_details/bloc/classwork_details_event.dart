part of 'classwork_details_bloc.dart';

sealed class ClassworkDetailsEvent extends Equatable {
  const ClassworkDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetClassworkDetails extends ClassworkDetailsEvent {
  const GetClassworkDetails({required this.classworkId});
  final int classworkId;
}

class IsTeacher extends ClassworkDetailsEvent {}

class PressToDelEdit extends ClassworkDetailsEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteClasswork extends ClassworkDetailsEvent {
  const DeleteClasswork({required this.classworkId});
  final int classworkId;
}
