part of 'select_students_bloc.dart';

class SelectStudentsState extends Equatable {
  const SelectStudentsState({
    this.allStudents = const BatchWiseStudent(),
  });

  final BatchWiseStudent allStudents;

  SelectStudentsState copyWith({BatchWiseStudent? allStudents}) {
    return SelectStudentsState(allStudents: allStudents ?? this.allStudents);
  }

  @override
  List<Object> get props => [allStudents];
}

final class SelectStudentsInitial extends SelectStudentsState {}
