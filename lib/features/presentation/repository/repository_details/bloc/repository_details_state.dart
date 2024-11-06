part of 'repository_details_bloc.dart';

class RepositoryDetailsState extends Equatable {
  const RepositoryDetailsState({
    this.details = const RepositoryDetails(),
  });

  final RepositoryDetails details;

  RepositoryDetailsState copyWith({
    RepositoryDetails? details,
  }) {
    return RepositoryDetailsState(
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [details];
}

final class RepositoryDetailsInitial extends RepositoryDetailsState {}
