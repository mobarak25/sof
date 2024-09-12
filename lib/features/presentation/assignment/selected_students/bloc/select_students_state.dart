part of 'select_students_bloc.dart';

class SelectStudentsState extends Equatable {
  const SelectStudentsState({
    this.selectAll = true,
    this.allStudents = const BatchWiseStudent(),
    this.selectedOptions = const [],
  });

  final bool selectAll;
  final BatchWiseStudent allStudents;
  final List<bool> selectedOptions;

  SelectStudentsState copyWith({
    bool? selectAll,
    BatchWiseStudent? allStudents,
    List<bool>? selectedOptions,
  }) {
    return SelectStudentsState(
      selectAll: selectAll ?? this.selectAll,
      allStudents: allStudents ?? this.allStudents,
      selectedOptions: selectedOptions ?? this.selectedOptions,
    );
  }

  @override
  List<Object> get props => [selectAll, allStudents, selectedOptions];
}

final class SelectStudentsInitial extends SelectStudentsState {}
