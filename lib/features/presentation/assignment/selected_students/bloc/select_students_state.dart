part of 'select_students_bloc.dart';

class SelectStudentsState extends Equatable {
  const SelectStudentsState({
    this.selectAll = true,
    this.allStudents = const [],
    this.copyStudents = const [],
  });

  final bool selectAll;
  final List<CheckUncheckStudents> allStudents;
  final List<CheckUncheckStudents> copyStudents;

  SelectStudentsState copyWith({
    bool? selectAll,
    List<CheckUncheckStudents>? allStudents,
    List<CheckUncheckStudents>? copyStudents,
  }) {
    return SelectStudentsState(
      selectAll: selectAll ?? this.selectAll,
      allStudents: allStudents ?? this.allStudents,
      copyStudents: copyStudents ?? this.copyStudents,
    );
  }

  @override
  List<Object> get props => [selectAll, allStudents, copyStudents];
}

final class SelectStudentsInitial extends SelectStudentsState {}
