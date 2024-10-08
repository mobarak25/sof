part of 'student_syllabus_bloc.dart';

class StudentSyllabusState extends Equatable {
  const StudentSyllabusState({
    this.page = 1,
    this.loading = false,
    this.isFirst = true,
    this.isTeacher = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.activeTab = '0',
    this.studentFullSyllabus = const StudentFullSyllabus(),
    this.classQuizText = const SyllabusTeacher(),
  });

  final int page;
  final bool loading;
  final bool isFirst;
  final bool isTeacher;
  final bool isEndList;
  final bool incrementLoader;
  final String activeTab;
  final StudentFullSyllabus studentFullSyllabus;
  final SyllabusTeacher classQuizText;

  StudentSyllabusState copyWith({
    int? page,
    bool? loading,
    bool? isFirst,
    bool? isTeacher,
    bool? isEndList,
    bool? incrementLoader,
    String? activeTab,
    StudentFullSyllabus? studentFullSyllabus,
    SyllabusTeacher? classQuizText,
  }) {
    return StudentSyllabusState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isFirst: isFirst ?? this.isFirst,
      isTeacher: isTeacher ?? this.isTeacher,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      activeTab: activeTab ?? this.activeTab,
      studentFullSyllabus: studentFullSyllabus ?? this.studentFullSyllabus,
      classQuizText: classQuizText ?? this.classQuizText,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isFirst,
        isTeacher,
        isEndList,
        incrementLoader,
        activeTab,
        studentFullSyllabus,
        classQuizText
      ];
}

final class StudentSyllabusInitial extends StudentSyllabusState {}
