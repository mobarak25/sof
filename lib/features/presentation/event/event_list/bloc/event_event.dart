part of 'event_bloc.dart';

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class GetInitialDate extends EventEvent {}

class DataForTab extends EventEvent {
  const DataForTab({required this.tabIndex});
  final String tabIndex;
}

class ChangeDate extends EventEvent {
  const ChangeDate({required this.date});
  final DateTime date;
}

class ChangeDay extends EventEvent {
  const ChangeDay({required this.date});
  final DateTime date;
}
