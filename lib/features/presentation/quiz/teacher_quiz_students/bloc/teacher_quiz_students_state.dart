part of 'teacher_quiz_students_bloc.dart';

class TeacherQuizStudentsState extends Equatable {
  const TeacherQuizStudentsState({
    this.page = 1,
    this.quizId = -1,
    this.loading = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.students = const QuizStudents(),
    this.quizDtls = const QuizDetailsForTeacher(),
  });

  final int quizId;
  final int page;
  final bool loading;
  final bool isEndList;
  final bool incrementLoader;
  final QuizStudents students;
  final QuizDetailsForTeacher quizDtls;

  TeacherQuizStudentsState copyWith({
    int? page,
    int? quizId,
    bool? loading,
    bool? isEndList,
    bool? incrementLoader,
    QuizStudents? students,
    QuizDetailsForTeacher? quizDtls,
  }) {
    return TeacherQuizStudentsState(
      page: page ?? this.page,
      quizId: quizId ?? this.quizId,
      loading: loading ?? this.loading,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      students: students ?? this.students,
      quizDtls: quizDtls ?? this.quizDtls,
    );
  }

  @override
  List<Object> get props => [
        page,
        quizId,
        loading,
        isEndList,
        incrementLoader,
        students,
        quizDtls,
      ];
}

final class TeacherQuizStudentsInitial extends TeacherQuizStudentsState {}
