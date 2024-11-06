import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/event_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(EventInitial()) {
    on<DataForTab>(_dataForTab);

    add(DataForTab(tabIndex: state.activeTab));
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(DataForTab event, Emitter<EventState> emit) async {
    emit(state.copyWith(loading: true, isEndList: false, isFirst: false));

    final queryParams = {
      "start_date": state.startDate,
      "end_date": state.endDate,
    };

    final eventList = await _apiRepo.get<EventList>(
        endpoint: buildUrl(eventEndPoint, queryParams));

    if (eventList != null) {
      emit(state.copyWith(eventList: eventList));
    }

    emit(state.copyWith(loading: false));
  }
}
