part of 'student_quiz_details_bloc.dart';

class StudentQuizDetailsState extends Equatable {
  const StudentQuizDetailsState({
    this.details = const QuizDetailsForStudent(),
  });

  final QuizDetailsForStudent details;

  StudentQuizDetailsState copyWith({QuizDetailsForStudent? details}) {
    return StudentQuizDetailsState(
      details: details ?? this.details,
    );
  }

  @override
  List<Object> get props => [details];
}

final class StudentQuizDetailsInitial extends StudentQuizDetailsState {}
