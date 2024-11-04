part of 'add_question_bloc.dart';

sealed class AddQuestionEvent extends Equatable {
  const AddQuestionEvent();

  @override
  List<Object> get props => [];
}

class GetQuestion extends AddQuestionEvent {
  const GetQuestion({required this.tempQst, required this.subjectId});
  final List<TempQuestion> tempQst;
  final int subjectId;
}

class ChangeSearch extends AddQuestionEvent {
  const ChangeSearch({required this.searchText, required this.filterBloc});
  final String searchText;
  final FilterSidebarBloc filterBloc;
}

class PressFilter extends AddQuestionEvent {
  const PressFilter({required this.filterBloc});
  final FilterSidebarBloc filterBloc;
}

class PressToDelEdit extends AddQuestionEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteQuestion extends AddQuestionEvent {
  const DeleteQuestion({required this.qId});
  final int qId;
}

class PageIncrement extends AddQuestionEvent {}

class CheckToggle extends AddQuestionEvent {
  const CheckToggle({required this.item, required this.isChecked});
  final QuestionItem item;
  final bool isChecked;
}

class RemoveTempQst extends AddQuestionEvent {
  const RemoveTempQst({required this.id});
  final int id;
}

class UpdateMarks extends AddQuestionEvent {}

class PressToAdd extends AddQuestionEvent {
  const PressToAdd({required this.checkedQsts});

  final List<TempQuestion> checkedQsts;
}
