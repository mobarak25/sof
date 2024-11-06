part of 'event_bloc.dart';

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class DataForTab extends EventEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}
