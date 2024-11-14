part of 'quiz_list_screen_bloc.dart';

class QuizListScreenState extends Equatable {
  const QuizListScreenState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.searchText = '',
    this.subjectId = -1,
    this.quizList = const QuizList(),
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final String searchText;
  final int subjectId;
  final QuizList quizList;

  QuizListScreenState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    String? searchText,
    int? subjectId,
    QuizList? quizList,
  }) {
    return QuizListScreenState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      searchText: searchText ?? this.searchText,
      subjectId: subjectId ?? this.subjectId,
      quizList: quizList ?? this.quizList,
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
        quizList
      ];
}

final class QuizListScreenInitial extends QuizListScreenState {}
