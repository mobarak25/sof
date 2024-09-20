part of 'classwork_details_bloc.dart';

class ClassworkDetailsState extends Equatable {
  const ClassworkDetailsState({
    this.isTeacher = false,
    this.details = const ClassworkDetails(),
  });
  final bool isTeacher;
  final ClassworkDetails details;

  ClassworkDetailsState copyWith({
    bool? isTeacher,
    ClassworkDetails? details,
  }) {
    return ClassworkDetailsState(
      isTeacher: isTeacher ?? this.isTeacher,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [isTeacher, details];
}

final class ClassworkDetailsInitial extends ClassworkDetailsState {}
