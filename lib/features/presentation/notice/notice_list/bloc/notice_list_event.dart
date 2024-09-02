part of 'notice_list_bloc.dart';

sealed class NoticeListEvent extends Equatable {
  const NoticeListEvent();

  @override
  List<Object> get props => [];
}

class GetNoticeList extends NoticeListEvent {}

class GetSearchedNotic extends NoticeListEvent {}

class ChangeSearch extends NoticeListEvent {
  const ChangeSearch({required this.searchValue});
  final String searchValue;
}

class PageIncrement extends NoticeListEvent {}
