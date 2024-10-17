part of 'teacher_attendance_bloc.dart';

class TeacherAttendanceState extends Equatable {
  const TeacherAttendanceState({
    this.page = 1,
    this.date = '',
    this.loading = false,
    this.isTeacher = false,
    this.isEndList = false,
    this.incrementLoader = false,
  });

  final int page;
  final String date;
  final bool loading;
  final bool isTeacher;
  final bool isEndList;
  final bool incrementLoader;

  TeacherAttendanceState copyWith({
    int? page,
    String? date,
    bool? loading,
    bool? isTeacher,
    bool? isEndList,
    bool? incrementLoader,
  }) {
    return TeacherAttendanceState(
      page: page ?? this.page,
      date: date ?? this.date,
      loading: loading ?? this.loading,
      isTeacher: isTeacher ?? this.isTeacher,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
    );
  }

  @override
  List<Object> get props => [
        page,
        date,
        loading,
        isTeacher,
        isEndList,
        incrementLoader,
      ];
}

final class TeacherAttendanceInitial extends TeacherAttendanceState {}
