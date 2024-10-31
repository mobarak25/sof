part of 'question_paper_list_bloc.dart';

class QuestionPaperListState extends Equatable {
  const QuestionPaperListState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.searchText = '',
    this.subjectId = -1,
    this.qstPapers = const QuestionPaperList(),
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final String searchText;
  final int subjectId;
  final QuestionPaperList qstPapers;

  QuestionPaperListState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    String? searchText,
    int? subjectId,
    QuestionPaperList? qstPapers,
  }) {
    return QuestionPaperListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      searchText: searchText ?? this.searchText,
      subjectId: subjectId ?? this.subjectId,
      qstPapers: qstPapers ?? this.qstPapers,
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
        qstPapers
      ];
}

final class QuestionPaperListInitial extends QuestionPaperListState {}
