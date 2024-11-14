part of 'select_child_bloc.dart';

sealed class SelectChildEvent extends Equatable {
  const SelectChildEvent();

  @override
  List<Object> get props => [];
}

class GetChilList extends SelectChildEvent {}

class SelectedId extends SelectChildEvent {
  const SelectedId({required this.sId, required this.userId});
  final int sId;
  final int userId;
}

class PressToConfirm extends SelectChildEvent {}
