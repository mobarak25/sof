import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';

import 'package:school_of_future/features/domain/entities/question_paper_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'question_paper_list_event.dart';
part 'question_paper_list_state.dart';

class QuestionPaperListBloc
    extends Bloc<QuestionPaperListEvent, QuestionPaperListState> {
  QuestionPaperListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(QuestionPaperListInitial()) {
    on<GetQstPaper>(_getQstPaper);

    add(GetQstPaper());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getQstPaper(
      GetQstPaper event, Emitter<QuestionPaperListState> emit) async {
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "search": state.searchText,
      "subject_id": state.subjectId,
    };

    final papers = await _apiRepo.get<QuestionPaperList>(
        endpoint: buildUrl(questionPaperListEndPoint, queryParams));

    if (papers != null) {
      emit(state.copyWith(qstPapers: papers));
    }
    emit(state.copyWith(loading: false));
  }
}
