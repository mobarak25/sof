part of 'teacher_attendance_bloc.dart';

class TeacherAttendanceState extends Equatable {
  const TeacherAttendanceState({
    this.date = '',
    this.loading = false,
    this.subjectId = -1,
    this.batchId = -1,
    this.className = '',
    this.isFirstTime = true,
    this.activeTab = '0',
    this.bacthAsSection = const GetBacthAsSections(),
    this.attendanceOverview = const AttendanceOverview(),
  });

  final String date;
  final int subjectId;
  final int batchId;
  final String className;
  final bool loading;
  final bool isFirstTime;
  final String activeTab;
  final GetBacthAsSections bacthAsSection;
  final AttendanceOverview attendanceOverview;

  TeacherAttendanceState copyWith({
    String? date,
    int? subjectId,
    int? batchId,
    String? className,
    bool? loading,
    bool? isFirstTime,
    String? activeTab,
    GetBacthAsSections? bacthAsSection,
    AttendanceOverview? attendanceOverview,
  }) {
    return TeacherAttendanceState(
      date: date ?? this.date,
      subjectId: subjectId ?? this.subjectId,
      batchId: batchId ?? this.batchId,
      className: className ?? this.className,
      loading: loading ?? this.loading,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      activeTab: activeTab ?? this.activeTab,
      bacthAsSection: bacthAsSection ?? this.bacthAsSection,
      attendanceOverview: attendanceOverview ?? this.attendanceOverview,
    );
  }

  @override
  List<Object> get props => [
        date,
        subjectId,
        batchId,
        className,
        loading,
        isFirstTime,
        activeTab,
        bacthAsSection,
        attendanceOverview
      ];
}

final class TeacherAttendanceInitial extends TeacherAttendanceState {}
