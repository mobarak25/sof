part of 'question_create_bloc.dart';

sealed class QuestionCreateEvent extends Equatable {
  const QuestionCreateEvent();

  @override
  List<Object> get props => [];
}

class QuestionIdForEdit extends QuestionCreateEvent {
  const QuestionIdForEdit({required this.qId});
  final int qId;
}

class ChangeTitle extends QuestionCreateEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class ChangeMark extends QuestionCreateEvent {
  const ChangeMark({required this.mark});
  final String mark;
}

class Explanation extends QuestionCreateEvent {
  const Explanation({required this.explanation});
  final String explanation;
}

class GetFile extends QuestionCreateEvent {}

class GetOptionFile extends QuestionCreateEvent {
  const GetOptionFile({required this.index});
  final int index;
}

class RemoveFile extends QuestionCreateEvent {
  const RemoveFile({required this.index});
  final int index;
}

class RemoveOptionFile extends QuestionCreateEvent {
  const RemoveOptionFile({required this.index});
  final int index;
}

//dropdown
class GetVersionList extends QuestionCreateEvent {}

class SelectVersionId extends QuestionCreateEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends QuestionCreateEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends QuestionCreateEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectLeevelId extends QuestionCreateEvent {
  const SelectLeevelId({required this.id});
  final dynamic id;
}

class SelectQuestionTypeId extends QuestionCreateEvent {
  const SelectQuestionTypeId({required this.id});
  final dynamic id;
}

//end dropdown

class GetQuestionLevel extends QuestionCreateEvent {}

class PressToCancel extends QuestionCreateEvent {}

class AddData extends QuestionCreateEvent {
  const AddData({
    required this.title,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
  });
  final String title;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
}

class AddOptions extends QuestionCreateEvent {}

class SelectMcqOptions extends QuestionCreateEvent {
  const SelectMcqOptions({required this.optionIndex});
  final dynamic optionIndex;
}

class PressToCreate extends QuestionCreateEvent {
  const PressToCreate({
    required this.titleFocusnode,
    required this.isDraft,
  });

  final bool isDraft;
  final FocusNode titleFocusnode;
}
