part of 'event_details_bloc.dart';

class EventDetailsState extends Equatable {
  const EventDetailsState({
    this.details = const EventDetails(),
  });

  final EventDetails details;

  EventDetailsState copyWith({EventDetails? details}) {
    return EventDetailsState(details: details ?? this.details);
  }

  @override
  List<Object> get props => [details];
}

final class EventDetailsInitial extends EventDetailsState {}
