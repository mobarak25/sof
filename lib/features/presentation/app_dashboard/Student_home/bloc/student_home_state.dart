part of 'student_home_bloc.dart';

class StudentHomeState extends Equatable {
  const StudentHomeState({
    this.version = '',
    this.profile = const StudentProfileResponse(),
    this.subjectList = const [],
    this.notice = const NoticeResponse(),
    this.dueTaskList = const DueTaskResponse(),
  });

  final String version;
  final StudentProfileResponse profile;
  final List<SubjectItem> subjectList;
  final NoticeResponse notice;
  final DueTaskResponse dueTaskList;

  StudentHomeState copyWith({
    String? version,
    StudentProfileResponse? profile,
    List<SubjectItem>? subjectList,
    NoticeResponse? notice,
    DueTaskResponse? dueTaskList,
  }) {
    return StudentHomeState(
      version: version ?? this.version,
      profile: profile ?? this.profile,
      subjectList: subjectList ?? this.subjectList,
      notice: notice ?? this.notice,
      dueTaskList: dueTaskList ?? this.dueTaskList,
    );
  }

  @override
  List<Object> get props => [
        version,
        profile,
        subjectList,
        notice,
        dueTaskList,
      ];
}

final class StudentHomeInitial extends StudentHomeState {}
