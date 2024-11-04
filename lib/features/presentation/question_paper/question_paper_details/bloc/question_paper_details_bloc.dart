import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'question_paper_details_event.dart';
part 'question_paper_details_state.dart';

class QuestionPaperDetailsBloc extends Bloc<QuestionPaperDetailsEvent, QuestionPaperDetailsState> {
  QuestionPaperDetailsBloc() : super(QuestionPaperDetailsInitial()) {
    on<QuestionPaperDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
