part of 'teacher_routine_bloc.dart';

class TeacherRoutineState extends Equatable {
  const TeacherRoutineState({
    this.page = 1,
    this.date = '',
    this.loading = false,
    this.isTeacher = false,
    this.isEndList = false,
    this.incrementLoader = false,
    this.routine = const Routine(),
  });

  final int page;
  final String date;
  final bool loading;
  final bool isTeacher;
  final bool isEndList;
  final bool incrementLoader;
  final Routine routine;

  TeacherRoutineState copyWith({
    int? page,
    String? date,
    bool? loading,
    bool? isTeacher,
    bool? isEndList,
    bool? incrementLoader,
    Routine? routine,
  }) {
    return TeacherRoutineState(
      page: page ?? this.page,
      date: date ?? this.date,
      loading: loading ?? this.loading,
      isTeacher: isTeacher ?? this.isTeacher,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      routine: routine ?? this.routine,
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
        routine,
      ];
}

final class TeacherRoutineInitial extends TeacherRoutineState {}
