part of 'select_students_bloc.dart';

sealed class SelectStudentsEvent extends Equatable {
  const SelectStudentsEvent();

  @override
  List<Object> get props => [];
}

class GetInitialStudents extends SelectStudentsEvent {
  const GetInitialStudents({required this.students});
  final BatchWiseStudent students;
}
