part of 'transport_bloc.dart';

sealed class TransportEvent extends Equatable {
  const TransportEvent();

  @override
  List<Object> get props => [];
}

class GetTransport extends TransportEvent {}
