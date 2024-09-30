part of 'lesson_plan_details_bloc.dart';

class LessonPlanDetailsState extends Equatable {
  const LessonPlanDetailsState({
    this.details = const LessonPlanDetails(),
    this.isTeacher = false,
  });

  final bool isTeacher;
  final LessonPlanDetails details;

  LessonPlanDetailsState copyWith({
    bool? isTeacher,
    LessonPlanDetails? details,
  }) {
    return LessonPlanDetailsState(
      isTeacher: isTeacher ?? this.isTeacher,
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [isTeacher, details];
}

final class LessonPlanDetailsInitial extends LessonPlanDetailsState {}
