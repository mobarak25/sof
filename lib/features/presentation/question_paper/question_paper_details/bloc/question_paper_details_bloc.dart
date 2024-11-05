import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/question_paper_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'question_paper_details_event.dart';
part 'question_paper_details_state.dart';

class QuestionPaperDetailsBloc
    extends Bloc<QuestionPaperDetailsEvent, QuestionPaperDetailsState> {
  QuestionPaperDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuestionPaperDetailsInitial()) {
    on<QuestionPaperDetails>(_questionPaperDetails);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _questionPaperDetails(QuestionPaperDetails event,
      Emitter<QuestionPaperDetailsState> emit) async {
    final details = await _apiRepo.get<QuestionPaperDtls>(
        endpoint: questionPaperDtlsEndPoint(qId: event.paperId));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
