part of 'theacher_mark_entry_bloc.dart';

sealed class TheacherMarkEntryEvent extends Equatable {
  const TheacherMarkEntryEvent();

  @override
  List<Object> get props => [];
}

class ExamIdForMarkEntry extends TheacherMarkEntryEvent {
  const ExamIdForMarkEntry({required this.examId});
  final int examId;
}

class SaveMark extends TheacherMarkEntryEvent {}
