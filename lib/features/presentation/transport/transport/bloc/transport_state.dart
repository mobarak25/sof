part of 'transport_bloc.dart';

class TransportState extends Equatable {
  const TransportState({
    this.transport = const Transport(),
  });

  final Transport transport;

  TransportState copyWith({Transport? transport}) {
    return TransportState(transport: transport ?? this.transport);
  }

  @override
  List<Object> get props => [transport];
}

final class TransportInitial extends TransportState {}
