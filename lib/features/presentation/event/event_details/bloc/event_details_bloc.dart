import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/event_details_response.dart';
import 'package:school_of_future/features/domain/entities/respository_details.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'event_details_event.dart';
part 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  EventDetailsBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(EventDetailsInitial()) {
    on<GetEventDetails>(_getEventDetails);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getEventDetails(
      GetEventDetails event, Emitter<EventDetailsState> emit) async {
    final details = await _apiRepo.get<EventDetails>(
        endpoint: eventDtlsEndPoint(id: event.id));

    if (details != null) {
      emit(state.copyWith(details: details));
    }
  }
}
