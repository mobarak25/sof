part of 'repository_list_bloc.dart';

class RepositoryListState extends Equatable {
  const RepositoryListState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.searchText = '',
    this.repositories = const Repositories(),
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final String searchText;

  final Repositories repositories;

  RepositoryListState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    String? searchText,
    Repositories? repositories,
  }) {
    return RepositoryListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      searchText: searchText ?? this.searchText,
      repositories: repositories ?? this.repositories,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isEndList,
        incrementLoader,
        searchText,
        repositories,
      ];
}

final class RepositoryListInitial extends RepositoryListState {}
