part of 'leave_details_bloc.dart';

class LeaveDetailsState extends Equatable {
  const LeaveDetailsState({
    this.details = const StudentLeaveLDetails(),
  });

  final StudentLeaveLDetails details;

  LeaveDetailsState copyWith({StudentLeaveLDetails? details}) {
    return LeaveDetailsState(details: details ?? this.details);
  }

  @override
  List<Object> get props => [details];
}

final class LeaveDetailsInitial extends LeaveDetailsState {}
