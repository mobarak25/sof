part of 'add_question_bloc.dart';

class AddQuestionState extends Equatable {
  const AddQuestionState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.searchText = '',
    this.subjectId = -1,
    this.totalQst = 0,
    this.totalMarks = 00,
    this.questionList = const QuestionBankList(),
    this.tempQst = const [],
    this.checkUncheck = const [],
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final String searchText;
  final int subjectId;
  final int totalQst;
  final num totalMarks;
  final QuestionBankList questionList;
  final List<TempQuestion> tempQst;
  final List<QstTempChecked> checkUncheck;

  AddQuestionState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    String? searchText,
    int? subjectId,
    int? totalQst,
    num? totalMarks,
    QuestionBankList? questionList,
    List<TempQuestion>? tempQst,
    List<QstTempChecked>? checkUncheck,
  }) {
    return AddQuestionState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      searchText: searchText ?? this.searchText,
      totalMarks: totalMarks ?? this.totalMarks,
      totalQst: totalQst ?? this.totalQst,
      subjectId: subjectId ?? this.subjectId,
      questionList: questionList ?? this.questionList,
      tempQst: tempQst ?? this.tempQst,
      checkUncheck: checkUncheck ?? this.checkUncheck,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isEndList,
        incrementLoader,
        searchText,
        subjectId,
        totalMarks,
        totalQst,
        questionList,
        tempQst,
        checkUncheck,
      ];
}

final class AddQuestionInitial extends AddQuestionState {}
