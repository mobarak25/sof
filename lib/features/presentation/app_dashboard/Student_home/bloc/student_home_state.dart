part of 'student_home_bloc.dart';

class StudentHomeState extends Equatable {
  const StudentHomeState({
    this.version = '',
    this.profile = const StudentProfileResponse(),
    this.nextClass = const NextClass(),
    this.todayActivity = const TodayActivities(),
    this.subjectList = const SubjectResponse(),
    this.notice = const NoticeResponse(),
    this.dueTaskList = const DueTaskResponse(),
  });

  final String version;
  final StudentProfileResponse profile;
  final NextClass nextClass;
  final TodayActivities todayActivity;
  final SubjectResponse subjectList;
  final NoticeResponse notice;
  final DueTaskResponse dueTaskList;

  StudentHomeState copyWith({
    String? version,
    StudentProfileResponse? profile,
    NextClass? nextClass,
    TodayActivities? todayActivity,
    SubjectResponse? subjectList,
    NoticeResponse? notice,
    DueTaskResponse? dueTaskList,
  }) {
    return StudentHomeState(
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
