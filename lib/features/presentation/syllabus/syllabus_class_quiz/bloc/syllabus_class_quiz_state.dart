part of 'syllabus_class_quiz_bloc.dart';

class SyllabusClassQuizState extends Equatable {
  const SyllabusClassQuizState({
    this.loading = false,
    this.classQuizTest = const SyllabusTeacher(),
    this.queryParams = const {},
  });
  final bool loading;
  final Map<String, dynamic> queryParams;
  final SyllabusTeacher classQuizTest;

  SyllabusClassQuizState copyWith({
    bool? loading,
    Map<String, dynamic>? queryParams,
    SyllabusTeacher? classQuizTest,
  }) {
    return SyllabusClassQuizState(
      loading: loading ?? this.loading,
      queryParams: queryParams ?? this.queryParams,
      classQuizTest: classQuizTest ?? this.classQuizTest,
    );
  }

  @override
  List<Object> get props => [loading, queryParams, classQuizTest];
}

final class SyllabusClassQuizInitial extends SyllabusClassQuizState {}
