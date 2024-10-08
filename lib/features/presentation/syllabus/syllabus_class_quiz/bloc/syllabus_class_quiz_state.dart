part of 'syllabus_class_quiz_bloc.dart';

class SyllabusClassQuizState extends Equatable {
  const SyllabusClassQuizState({
    this.loading = false,
    this.page = 1,
    this.isTeacher = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.classQuizTest = const SyllabusTeacher(),
    this.queryParams = const {},
  });

  final bool loading;
  final int page;
  final bool isTeacher;
  final bool isEndList;
  final bool incrementLoader;
  final Map<String, dynamic> queryParams;
  final SyllabusTeacher classQuizTest;

  SyllabusClassQuizState copyWith({
    bool? loading,
    int? page,
    bool? isTeacher,
    bool? isEndList,
    bool? incrementLoader,
    Map<String, dynamic>? queryParams,
    SyllabusTeacher? classQuizTest,
  }) {
    return SyllabusClassQuizState(
      loading: loading ?? this.loading,
      page: page ?? this.page,
      isTeacher: isTeacher ?? this.isTeacher,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      queryParams: queryParams ?? this.queryParams,
      classQuizTest: classQuizTest ?? this.classQuizTest,
    );
  }

  @override
  List<Object> get props => [
        loading,
        page,
        isTeacher,
        isEndList,
        incrementLoader,
        queryParams,
        classQuizTest
      ];
}

final class SyllabusClassQuizInitial extends SyllabusClassQuizState {}
