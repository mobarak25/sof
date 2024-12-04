part of 'student_home_bloc.dart';

class StudentHomeState extends Equatable {
  const StudentHomeState({
    this.loading = false,
    this.version = '',
    this.profile = const StudentProfileResponse(),
    this.nextClass = const NextClass(),
    this.todayActivity = const TodayActivities(),
    this.subjectList = const SubjectResponse(),
    this.notice = const DashboardNoticeRes(),
    this.dueTaskList = const DueTaskResponse(),
  });

  final bool loading;
  final String version;
  final StudentProfileResponse profile;
  final NextClass nextClass;
  final TodayActivities todayActivity;
  final SubjectResponse subjectList;
  final DashboardNoticeRes notice;
  final DueTaskResponse dueTaskList;

  StudentHomeState copyWith({
    bool? loading,
    String? version,
    StudentProfileResponse? profile,
    NextClass? nextClass,
    TodayActivities? todayActivity,
    SubjectResponse? subjectList,
    DashboardNoticeRes? notice,
    DueTaskResponse? dueTaskList,
  }) {
    return StudentHomeState(
      loading: loading ?? this.loading,
      version: version ?? this.version,
      profile: profile ?? this.profile,
      nextClass: nextClass ?? this.nextClass,
      todayActivity: todayActivity ?? this.todayActivity,
      subjectList: subjectList ?? this.subjectList,
      notice: notice ?? this.notice,
      dueTaskList: dueTaskList ?? this.dueTaskList,
    );
  }

  @override
  List<Object> get props => [
        loading,
        version,
        profile,
        nextClass,
        todayActivity,
        subjectList,
        notice,
        dueTaskList,
      ];
}

final class StudentHomeInitial extends StudentHomeState {}
