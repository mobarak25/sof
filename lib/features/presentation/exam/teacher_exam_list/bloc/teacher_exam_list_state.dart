part of 'teacher_exam_list_bloc.dart';

class TeacherExamListState extends Equatable {
  const TeacherExamListState({
    this.page = 1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.searchText = '',
    this.subjectId = -1,
    this.examList = const ExamList(),
  });

  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final String searchText;
  final int subjectId;
  final ExamList examList;

  TeacherExamListState copyWith({
    int? page,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    String? searchText,
    int? subjectId,
    ExamList? examList,
  }) {
    return TeacherExamListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      searchText: searchText ?? this.searchText,
      subjectId: subjectId ?? this.subjectId,
      examList: examList ?? this.examList,
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
        examList
      ];
}

final class TeacherExamListInitial extends TeacherExamListState {}
