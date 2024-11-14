part of 'create_quiz_bloc.dart';

sealed class CreateQuizEvent extends Equatable {
  const CreateQuizEvent();

  @override
  List<Object> get props => [];
}

class QuizIdForEdit extends CreateQuizEvent {
  const QuizIdForEdit({required this.quizId});
  final int quizId;
}

class ChangeTitle extends CreateQuizEvent {
  const ChangeTitle({required this.title});
  final String title;
}

class StartDate extends CreateQuizEvent {
  const StartDate({required this.startDate});
  final String startDate;
}

class EndDate extends CreateQuizEvent {
  const EndDate({required this.endDate});
  final String endDate;
}

class ChangeDuration extends CreateQuizEvent {
  const ChangeDuration({required this.duration});
  final String duration;
}

class ChangePassPercentage extends CreateQuizEvent {
  const ChangePassPercentage({required this.passPercentage});
  final String passPercentage;
}

class ChangeGraceTime extends CreateQuizEvent {
  const ChangeGraceTime({required this.graceTime});
  final String graceTime;
}

class IsCommon extends CreateQuizEvent {
  const IsCommon({required this.common});
  final bool common;
}

class AllowLateSub extends CreateQuizEvent {
  const AllowLateSub({required this.isLateSub});
  final bool isLateSub;
}

class IsMarkEditable extends CreateQuizEvent {
  const IsMarkEditable({required this.isMarkEditable});
  final bool isMarkEditable;
}

class AllowRetake extends CreateQuizEvent {
  const AllowRetake({required this.allowRetake});
  final bool allowRetake;
}

class CheckSubjectId extends CreateQuizEvent {
  const CheckSubjectId({required this.id});
  final dynamic id;
}

class SelectedQuestions extends CreateQuizEvent {
  const SelectedQuestions({required this.qst});
  final List<TempQuestion> qst;
}

//dropdown
class GetVersionList extends CreateQuizEvent {}

class SelectVersionId extends CreateQuizEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends CreateQuizEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends CreateQuizEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectSectionId extends CreateQuizEvent {
  const SelectSectionId({required this.id});
  final dynamic id;
}

class SelectLeevelId extends CreateQuizEvent {
  const SelectLeevelId({required this.id});
  final dynamic id;
}

class SelectSectionList extends CreateQuizEvent {
  const SelectSectionList({required this.sectionList});
  final List<dynamic> sectionList;
}
//end dropdown

class BackWithUnselected extends CreateQuizEvent {
  const BackWithUnselected({required this.students, required this.index});
  final List<CheckUncheckStudents> students;
  final int index;
}

class GetQuestionLevel extends CreateQuizEvent {}

class PressToCreate extends CreateQuizEvent {
  const PressToCreate({
    required this.titleFocusnode,
    required this.isDraft,
  });

  final bool isDraft;

  final FocusNode titleFocusnode;
}

class PressToCancel extends CreateQuizEvent {}

class AddData extends CreateQuizEvent {
  const AddData({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.passPercentage,
    required this.graceTime,
    required this.isCommon,
    required this.allowLateSub,
    required this.isMarkEditable,
    required this.allowRetake,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.selectLevelId,
    required this.selectedQstns,
    required this.fullMark,
  });
  final String title;
  final String startDate;
  final String endDate;
  final String duration;
  final int passPercentage;
  final int graceTime;
  final int isCommon;
  final int allowLateSub;
  final int isMarkEditable;
  final int allowRetake;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectLevelId;
  final List<TempQuestion> selectedQstns;
  final num fullMark;
}
