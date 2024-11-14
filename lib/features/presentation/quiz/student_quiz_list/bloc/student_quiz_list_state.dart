part of 'student_quiz_list_bloc.dart';

class StudentQuizListState extends Equatable {
  const StudentQuizListState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.searchText = '',
    this.startDate = '',
    this.endDate = '',
    this.subjectId = -1,
    this.quizList = const QuizList(),
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final String searchText;
  final String startDate;
  final String endDate;
  final int subjectId;
  final QuizList quizList;

  StudentQuizListState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    String? searchText,
    String? startDate,
    String? endDate,
    int? subjectId,
    QuizList? quizList,
  }) {
    return StudentQuizListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      searchText: searchText ?? this.searchText,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
        startDate,
        endDate,
        subjectId,
        quizList
      ];
}

final class StudentQuizListInitial extends StudentQuizListState {}
