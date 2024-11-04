part of 'question_paper_create_bloc.dart';

sealed class QuestionPaperCreateEvent extends Equatable {
  const QuestionPaperCreateEvent();

  @override
  List<Object> get props => [];
}

class QuestionPaperIdForEdit extends QuestionPaperCreateEvent {
  const QuestionPaperIdForEdit({required this.qPaperId});
  final int qPaperId;
}

class ChangeTitle extends QuestionPaperCreateEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class StartDate extends QuestionPaperCreateEvent {
  const StartDate({required this.startDate});
  final String startDate;
}

class ChangeType extends QuestionPaperCreateEvent {
  const ChangeType({required this.type});
  final String type;
}

class ChangeDuration extends QuestionPaperCreateEvent {
  const ChangeDuration({required this.duration});
  final String duration;
}

//dropdown
class GetVersionList extends QuestionPaperCreateEvent {}

class SelectVersionId extends QuestionPaperCreateEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends QuestionPaperCreateEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends QuestionPaperCreateEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectSectionId extends QuestionPaperCreateEvent {
  const SelectSectionId({required this.id});
  final dynamic id;
}

class CheckSubjectId extends QuestionPaperCreateEvent {
  const CheckSubjectId({required this.id});
  final dynamic id;
}

//end dropdown

class PressToCancel extends QuestionPaperCreateEvent {}

class PressToConfirmCancel extends QuestionPaperCreateEvent {}

class SelectedQuestions extends QuestionPaperCreateEvent {
  const SelectedQuestions({required this.qst});
  final List<TempQuestion> qst;
}

class AddData extends QuestionPaperCreateEvent {
  const AddData({
    required this.title,
    required this.startDate,
    required this.type,
    required this.duration,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.selectedSectionId,
    required this.selectedQstns,
    required this.fullMark,
  });
  final String title;
  final String startDate;
  final String type;
  final String duration;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectedSectionId;
  final List<TempQuestion> selectedQstns;
  final num fullMark;
}

class AddOptions extends QuestionPaperCreateEvent {}

class PressToCreate extends QuestionPaperCreateEvent {
  const PressToCreate({
    required this.titleFocusnode,
    required this.startDateFocusnode,
    required this.typeFocusnode,
    required this.durationFocusnode,
    required this.isDraft,
  });

  final bool isDraft;
  final FocusNode titleFocusnode;
  final FocusNode startDateFocusnode;
  final FocusNode typeFocusnode;
  final FocusNode durationFocusnode;
}
