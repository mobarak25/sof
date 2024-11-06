part of 'repository_list_bloc.dart';

sealed class RepositoryListEvent extends Equatable {
  const RepositoryListEvent();

  @override
  List<Object> get props => [];
}

class GetRepository extends RepositoryListEvent {}

class ChangeSearch extends RepositoryListEvent {
  const ChangeSearch({required this.searchText});
  final String searchText;
}

class PageIncrement extends RepositoryListEvent {}
