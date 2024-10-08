part of 'syllabus_details_bloc.dart';

sealed class SyllabusDetailsEvent extends Equatable {
  const SyllabusDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetSyllabusDetails extends SyllabusDetailsEvent {
  const GetSyllabusDetails({required this.id});
  final int id;
}
