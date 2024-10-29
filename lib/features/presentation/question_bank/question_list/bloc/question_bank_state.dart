part of 'question_bank_bloc.dart';

class QuestionBankState extends Equatable {
  const QuestionBankState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.searchText = '',
    this.subjectId = -1,
    this.questionList = const QuestionBankList(),
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final String searchText;
  final int subjectId;
  final QuestionBankList questionList;

  QuestionBankState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    String? searchText,
    int? subjectId,
    QuestionBankList? questionList,
  }) {
    return QuestionBankState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      searchText: searchText ?? this.searchText,
      subjectId: subjectId ?? this.subjectId,
      questionList: questionList ?? this.questionList,
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
        questionList
      ];
}

final class QuestionBankInitial extends QuestionBankState {}
