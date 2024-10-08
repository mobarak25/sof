part of 'syllabus_details_bloc.dart';

class SyllabusDetailsState extends Equatable {
  const SyllabusDetailsState({
    this.details = const SyllabusDetails(),
  });

  final SyllabusDetails details;

  SyllabusDetailsState copyWith({
    SyllabusDetails? details,
  }) {
    return SyllabusDetailsState(
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [details];
}

final class SyllabusDetailsInitial extends SyllabusDetailsState {}
