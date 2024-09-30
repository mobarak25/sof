import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'theacher_meeting_list_event.dart';
part 'theacher_meeting_list_state.dart';

class TheacherMeetingListBloc
    extends Bloc<TheacherMeetingListEvent, TheacherMeetingListState> {
  TheacherMeetingListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TheacherMeetingListInitial()) {
    on<DataForTab>(_dataForTab);
    on<ChangeSearch>(_changeSearch);
    on<GetSearchedMeeting>(_getSearchedMeeting);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteMeeting>(_deleteMeeting);
    on<PressFilter>(_pressFilter);
    on<PageIncrement>(_pageIncrement);
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<TheacherMeetingListState> emit) {}

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<TheacherMeetingListState> emit) {}

  FutureOr<void> _getSearchedMeeting(
      GetSearchedMeeting event, Emitter<TheacherMeetingListState> emit) {}

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<TheacherMeetingListState> emit) {}

  FutureOr<void> _deleteMeeting(
      DeleteMeeting event, Emitter<TheacherMeetingListState> emit) {}

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<TheacherMeetingListState> emit) {}

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<TheacherMeetingListState> emit) {}
}
