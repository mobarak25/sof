part of 'notice_details_bloc.dart';

sealed class NoticeDetailsEvent extends Equatable {
  const NoticeDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetNoticeDetails extends NoticeDetailsEvent {
  const GetNoticeDetails({required this.noticeId});
  final int noticeId;
}
