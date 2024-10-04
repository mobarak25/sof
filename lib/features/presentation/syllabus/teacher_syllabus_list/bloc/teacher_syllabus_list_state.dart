part of 'teacher_syllabus_list_bloc.dart';

class TeacherSyllabusListState extends Equatable {
  const TeacherSyllabusListState({
    this.page = 1,
    this.loading = false,
    this.isFirst = true,
    this.isTeacher = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.activeTab = '0',
    this.teacherFullSyllabus = const FullSyllabusTeacher(),
    this.classQuizText = const SyllabusTeacher(),
  });

  final int page;
  final bool loading;
  final bool isFirst;
  final bool isTeacher;
  final bool isEndList;
  final bool incrementLoader;
  final String activeTab;
  final FullSyllabusTeacher teacherFullSyllabus;
  final SyllabusTeacher classQuizText;

  TeacherSyllabusListState copyWith({
    int? page,
    bool? loading,
    bool? isFirst,
    bool? isTeacher,
    bool? isEndList,
    bool? incrementLoader,
    String? activeTab,
    FullSyllabusTeacher? teacherFullSyllabus,
    SyllabusTeacher? classQuizText,
  }) {
    return TeacherSyllabusListState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isFirst: isFirst ?? this.isFirst,
      isTeacher: isTeacher ?? this.isTeacher,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      activeTab: activeTab ?? this.activeTab,
      teacherFullSyllabus: teacherFullSyllabus ?? this.teacherFullSyllabus,
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
        teacherFullSyllabus,
        classQuizText
      ];
}

final class TeacherSyllabusListInitial extends TeacherSyllabusListState {}
