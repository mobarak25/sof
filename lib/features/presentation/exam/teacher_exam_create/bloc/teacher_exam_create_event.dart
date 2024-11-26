part of 'teacher_exam_create_bloc.dart';

sealed class TeacherExamCreateEvent extends Equatable {
  const TeacherExamCreateEvent();

  @override
  List<Object> get props => [];
}

class ExamIdForEdit extends TeacherExamCreateEvent {
  const ExamIdForEdit({required this.examId});
  final int examId;
}

class ExamDate extends TeacherExamCreateEvent {
  const ExamDate({required this.examDate});
  final String examDate;
}

class StartTime extends TeacherExamCreateEvent {
  const StartTime({required this.startTime});
  final String startTime;
}

class EndTime extends TeacherExamCreateEvent {
  const EndTime({required this.endTime});
  final String endTime;
}

class ChangeMaxMark extends TeacherExamCreateEvent {
  const ChangeMaxMark({required this.maxMark});
  final String maxMark;
}

class ChangeConvertMark extends TeacherExamCreateEvent {
  const ChangeConvertMark({required this.convertMark});
  final String convertMark;
}

class ChangePassMark extends TeacherExamCreateEvent {
  const ChangePassMark({required this.passMark});
  final String passMark;
}

//dropdown
class GetVersionList extends TeacherExamCreateEvent {}

class SelectVersionId extends TeacherExamCreateEvent {
  const SelectVersionId({required this.id});
  final dynamic id;
}

class SelectClassId extends TeacherExamCreateEvent {
  const SelectClassId({required this.id});
  final dynamic id;
}

class SelectSubjectId extends TeacherExamCreateEvent {
  const SelectSubjectId({required this.id});
  final dynamic id;
}

class SelectSectionId extends TeacherExamCreateEvent {
  const SelectSectionId({required this.id});
  final dynamic id;
}

//end dropdown

class SelectGroupId extends TeacherExamCreateEvent {
  const SelectGroupId({required this.id});
  final dynamic id;
}

class SelectTermId extends TeacherExamCreateEvent {
  const SelectTermId({required this.id});
  final dynamic id;
}

class PressToCancel extends TeacherExamCreateEvent {}

class PressToConfirmCancel extends TeacherExamCreateEvent {}

class AddData extends TeacherExamCreateEvent {
  const AddData({
    required this.examDate,
    required this.startTime,
    required this.endTime,
    required this.maxMark,
    required this.convertMark,
    required this.passMark,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.selectedSectionId,
    required this.selectedExamGroupId,
    required this.selectTermId,
  });
  final String examDate;
  final String startTime;
  final String endTime;
  final String maxMark;
  final String convertMark;
  final String passMark;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectedSectionId;
  final dynamic selectedExamGroupId;
  final dynamic selectTermId;
}

class PressToCreate extends TeacherExamCreateEvent {
  const PressToCreate({
    required this.examDateFocusnode,
    required this.startTimeFocusnode,
    required this.endTimeFocusnode,
    required this.maxMarkFocusnode,
    required this.convertMarkFocusnode,
    required this.passMarkFocusnode,
  });

  final FocusNode examDateFocusnode;
  final FocusNode startTimeFocusnode;
  final FocusNode endTimeFocusnode;
  final FocusNode maxMarkFocusnode;
  final FocusNode convertMarkFocusnode;
  final FocusNode passMarkFocusnode;
}
