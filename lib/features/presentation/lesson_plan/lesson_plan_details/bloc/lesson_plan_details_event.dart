part of 'lesson_plan_details_bloc.dart';

sealed class LessonPlanDetailsEvent extends Equatable {
  const LessonPlanDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetLessonPlanDetails extends LessonPlanDetailsEvent {
  const GetLessonPlanDetails({required this.planId});
  final int planId;
}

class IsTeacher extends LessonPlanDetailsEvent {}

class PressToDelEdit extends LessonPlanDetailsEvent {
  const PressToDelEdit({required this.id, required this.type});
  final int id;
  final String type;
}

class DeleteLessonPlan extends LessonPlanDetailsEvent {
  const DeleteLessonPlan({required this.lessonId});
  final int lessonId;
}
