part of 'notice_details_bloc.dart';

class NoticeDetailsState extends Equatable {
  const NoticeDetailsState({
    this.details = const NoticeDetailsResponse(),
    this.attachment = const [],
  });

  final NoticeDetailsResponse details;
  final List<String?> attachment;

  NoticeDetailsState copyWith({
    NoticeDetailsResponse? details,
    List<String?>? attachment,
  }) {
    return NoticeDetailsState(
      details: details ?? this.details,
      attachment: attachment ?? this.attachment,
    );
  }

  @override
  List<Object> get props => [details, attachment];
}

final class NoticeDetailsInitial extends NoticeDetailsState {}
