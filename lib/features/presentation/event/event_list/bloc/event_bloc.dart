import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/event_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(EventInitial()) {
    on<GetInitialDate>(_getInitialDate);
    on<DataForTab>(_dataForTab);
    on<ChangeDate>(_changeDate);
    on<ChangeDay>(_changeDay);

    add(GetInitialDate());
    add(DataForTab(tabIndex: state.activeTab));
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getInitialDate(
      GetInitialDate event, Emitter<EventState> emit) {
    String startDate = getDate(
        value: getFirstDateOfMonth(DateTime.now()).toString(),
        formate: "yyyy-MM-dd");

    String endDate = getDate(
        value: getLastDayOfMonth(DateTime.now()).toString(),
        formate: "yyyy-MM-dd");

    emit(state.copyWith(
        startDate: startDate,
        endDate: endDate,
        userId: _localStorageRepo.read(key: userIdDB)!));
  }

  FutureOr<void> _dataForTab(DataForTab event, Emitter<EventState> emit) async {
    emit(state.copyWith(
      activeTab: event.tabIndex,
      loading: true,
      isEndList: false,
      isFirst: false,
    ));
    final queryParams = {
      "start_date": state.startDate,
      "end_date": state.endDate,
      "user_id": state.userId,
    };

    final eventList = await _apiRepo.get<EventList>(
        endpoint: buildUrl(eventEndPoint, queryParams));

    if (eventList != null) {
      Map<String, int> events = {};

      for (int i = 0; i < eventList.data!.length; i++) {
        String monthAndDate =
            getDate(value: eventList.data![i].startDate!, formate: "MM-dd");
        events[monthAndDate] = 1;
      }

      emit(state.copyWith(eventList: eventList, events: events));
    }

    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeDate(ChangeDate event, Emitter<EventState> emit) {
    String startDate = getDate(
        value: getFirstDateOfMonth(event.date).toString(),
        formate: "yyyy-MM-dd");

    String endDate = getDate(
        value: getLastDayOfMonth(event.date).toString(), formate: "yyyy-MM-dd");

    emit(state.copyWith(startDate: startDate, endDate: endDate));
    add(DataForTab(tabIndex: state.activeTab));
  }

  FutureOr<void> _changeDay(ChangeDay event, Emitter<EventState> emit) async {
    final date = getDate(value: event.date.toString(), formate: "yyyy-MM-dd");
    emit(state.copyWith(loading: true));
    final queryParams = {
      "start_date": date,
      "end_date": date,
      "user_id": state.userId,
    };

    final eventList = await _apiRepo.get<EventList>(
        endpoint: buildUrl(eventEndPoint, queryParams));

    if (eventList != null) {
      emit(state.copyWith(eventList: eventList, loading: false));
    }
  }
}
