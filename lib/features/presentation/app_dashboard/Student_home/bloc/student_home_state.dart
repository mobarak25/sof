part of 'student_home_bloc.dart';

class StudentHomeState extends Equatable {
  const StudentHomeState({
    this.loading = false,
    this.version = '',
    this.isTeacher = false,
    this.profile = const StudentProfileResponse(),
    this.nextClass = const NextClass(),
    this.todayActivity = const TodayActivities(),
    this.subjectList = const SubjectResponse(),
    this.notice = const DashboardNoticeRes(),
    this.dueTaskList = const DueTaskResponse(),
    this.homework = const TeacherAssignment(),
    this.studentHomework = const AssignmentResponse(),
    this.examList = const ExamList(),
  });

  final bool loading;
  final String version;
  final bool isTeacher;
  final StudentProfileResponse profile;
  final NextClass nextClass;
  final TodayActivities todayActivity;
  final SubjectResponse subjectList;
  final DashboardNoticeRes notice;
  final DueTaskResponse dueTaskList;
  final TeacherAssignment homework;
  final AssignmentResponse studentHomework;
  final ExamList examList;

  StudentHomeState copyWith({
    bool? loading,
    String? version,
    bool? isTeacher,
    StudentProfileResponse? profile,
    NextClass? nextClass,
    TodayActivities? todayActivity,
    SubjectResponse? subjectList,
    DashboardNoticeRes? notice,
    DueTaskResponse? dueTaskList,
    TeacherAssignment? homework,
    ExamList? examList,
    AssignmentResponse? studentHomework,
  }) {
    return StudentHomeState(
      loading: loading ?? this.loading,
      version: version ?? this.version,
      isTeacher: isTeacher ?? this.isTeacher,
      profile: profile ?? this.profile,
      nextClass: nextClass ?? this.nextClass,
      todayActivity: todayActivity ?? this.todayActivity,
      subjectList: subjectList ?? this.subjectList,
      notice: notice ?? this.notice,
      dueTaskList: dueTaskList ?? this.dueTaskList,
      homework: homework ?? this.homework,
      examList: examList ?? this.examList,
      studentHomework: studentHomework ?? this.studentHomework,
    );
  }

  @override
  List<Object> get props => [
        loading,
        version,
        isTeacher,
        profile,
        nextClass,
        todayActivity,
        subjectList,
        notice,
        dueTaskList,
        homework,
        examList,
        studentHomework,
      ];
}

final class StudentHomeInitial extends StudentHomeState {}
