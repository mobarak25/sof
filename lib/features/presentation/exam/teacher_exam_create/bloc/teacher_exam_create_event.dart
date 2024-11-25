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

class PressToCancel extends TeacherExamCreateEvent {}

class PressToConfirmCancel extends TeacherExamCreateEvent {}

class AddData extends TeacherExamCreateEvent {
  const AddData({
    required this.examDate,
    required this.selectedVersionId,
    required this.selectedClassId,
    required this.selectedSubjectId,
    required this.selectedSectionId,
  });
  final String examDate;
  final dynamic selectedVersionId;
  final dynamic selectedClassId;
  final dynamic selectedSubjectId;
  final dynamic selectedSectionId;
}

class PressToCreate extends TeacherExamCreateEvent {
  const PressToCreate({
    required this.examDateFocusnode,
    required this.typeFocusnode,
    required this.durationFocusnode,
    required this.isDraft,
  });

  final bool isDraft;
  final FocusNode examDateFocusnode;
  final FocusNode typeFocusnode;
  final FocusNode durationFocusnode;
}
