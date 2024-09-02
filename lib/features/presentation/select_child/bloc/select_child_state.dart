part of 'select_child_bloc.dart';

class SelectChildState extends Equatable {
  const SelectChildState({
    this.childList = const ChildListResponse(),
    this.selectedId = -1,
  });

  final ChildListResponse childList;
  final int selectedId;

  SelectChildState copyWith({ChildListResponse? childList, int? selectedId}) {
    return SelectChildState(
      childList: childList ?? this.childList,
      selectedId: selectedId ?? this.selectedId,
    );
  }

  @override
  List<Object> get props => [childList, selectedId];
}

final class SelectChildInitial extends SelectChildState {}
