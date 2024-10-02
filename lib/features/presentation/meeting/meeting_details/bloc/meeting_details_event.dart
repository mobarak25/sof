part of 'meeting_details_bloc.dart';

sealed class MeetingDetailsEvent extends Equatable {
  const MeetingDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetMeetingDetails extends MeetingDetailsEvent {
  const GetMeetingDetails({required this.meetingId});
  final int meetingId;
}

class IsTeacher extends MeetingDetailsEvent {}

class PressToDelEdit extends MeetingDetailsEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteResource extends MeetingDetailsEvent {
  const DeleteResource({required this.resourceId});
  final int resourceId;
}

class OpenListDialog extends MeetingDetailsEvent {}
