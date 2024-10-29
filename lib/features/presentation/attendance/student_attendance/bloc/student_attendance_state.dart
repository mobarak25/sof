part of 'student_attendance_bloc.dart';

class StudentAttendanceState extends Equatable {
  const StudentAttendanceState({
    this.loading = false,
    this.isFirstTime = true,
    this.lastDate = '',
    this.events = const {},
    this.studentOverview = const AttendanceOverview(),
    this.calenderOverview = const CalanderAttendanceOverview(),
    this.todayStatus = const TodayAttendanceStatus(),
  });

  final bool loading;
  final bool isFirstTime;
  final String lastDate;
  final AttendanceOverview studentOverview;
  final CalanderAttendanceOverview calenderOverview;
  final TodayAttendanceStatus todayStatus;
  final Map<String, int> events;

  StudentAttendanceState copyWith({
    bool? loading,
    bool? isFirstTime,
    String? lastDate,
    Map<String, int>? events,
    AttendanceOverview? studentOverview,
    TodayAttendanceStatus? todayStatus,
    CalanderAttendanceOverview? calenderOverview,
  }) {
    return StudentAttendanceState(
      loading: loading ?? this.loading,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      lastDate: lastDate ?? this.lastDate,
      events: events ?? this.events,
      studentOverview: studentOverview ?? this.studentOverview,
      todayStatus: todayStatus ?? this.todayStatus,
      calenderOverview: calenderOverview ?? this.calenderOverview,
    );
  }

  @override
  List<Object> get props => [
        loading,
        isFirstTime,
        lastDate,
        events,
        todayStatus,
        studentOverview,
      ];
}

final class StudentAttendanceInitial extends StudentAttendanceState {}
