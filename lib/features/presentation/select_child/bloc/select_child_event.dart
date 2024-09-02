part of 'select_child_bloc.dart';

sealed class SelectChildEvent extends Equatable {
  const SelectChildEvent();

  @override
  List<Object> get props => [];
}

class GetChilList extends SelectChildEvent {}

class SelectedId extends SelectChildEvent {
  const SelectedId({required this.sId});
  final int sId;
}

class PressToConfirm extends SelectChildEvent {}
