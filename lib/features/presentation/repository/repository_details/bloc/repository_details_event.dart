part of 'repository_details_bloc.dart';

sealed class RepositoryDetailsEvent extends Equatable {
  const RepositoryDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetRepositoryDetails extends RepositoryDetailsEvent {
  const GetRepositoryDetails({required this.id});
  final int id;
}
