part of 'quiz_finish_bloc.dart';

class QuizFinishState extends Equatable {
  const QuizFinishState({
    this.haveAnyShortQst = false,
    this.details = const QuizDetailsForStudent(),
    this.profile = const StudentProfileResponse(),
  });

  final bool haveAnyShortQst;
  final QuizDetailsForStudent details;
  final StudentProfileResponse profile;

  QuizFinishState copyWith({
    bool? haveAnyShortQst,
    QuizDetailsForStudent? details,
    StudentProfileResponse? profile,
  }) {
    return QuizFinishState(
      details: details ?? this.details,
      profile: profile ?? this.profile,
      haveAnyShortQst: haveAnyShortQst ?? this.haveAnyShortQst,
    );
  }

  @override
  List<Object> get props => [haveAnyShortQst, details, profile];
}

final class QuizFinishInitial extends QuizFinishState {}
