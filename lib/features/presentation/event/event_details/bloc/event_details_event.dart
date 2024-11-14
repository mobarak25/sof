part of 'event_details_bloc.dart';

sealed class EventDetailsEvent extends Equatable {
  const EventDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetEventDetails extends EventDetailsEvent {
  const GetEventDetails({required this.id});
  final int id;
}
