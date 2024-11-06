import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/syllabus_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'syllabus_details_event.dart';
part 'syllabus_details_state.dart';

class SyllabusDetailsBloc
    extends Bloc<SyllabusDetailsEvent, SyllabusDetailsState> {
  SyllabusDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(SyllabusDetailsInitial()) {
    on<GetSyllabusDetails>(_getSyllabusDetails);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getSyllabusDetails(
      GetSyllabusDetails event, Emitter<SyllabusDetailsState> emit) async {
    final details = await _apiRepo.get<SyllabusDetails>(
        endpoint: syllabusDetailsEndPoint(syllabusId: event.id));
    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
