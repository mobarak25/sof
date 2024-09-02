part of 'notice_list_bloc.dart';

class NoticeListState extends Equatable {
  const NoticeListState({
    this.searchText = '',
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.notice = const NoticeResponse(),
  });

  final String searchText;
  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final NoticeResponse notice;

  NoticeListState copyWith({
    String? searchText,
    int? page,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    NoticeResponse? notice,
  }) {
    return NoticeListState(
      searchText: searchText ?? this.searchText,
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      notice: notice ?? this.notice,
    );
  }

  @override
  List<Object> get props =>
      [searchText, page, isEndList, loading, incrementLoader, notice];
}

final class NoticeListInitial extends NoticeListState {}
