import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/debounce.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/confirm_delete_dialog.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/meeting_list_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/domain/usecases/local_data.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';

part 'theacher_meeting_list_event.dart';
part 'theacher_meeting_list_state.dart';

class TheacherMeetingListBloc
    extends Bloc<TheacherMeetingListEvent, TheacherMeetingListState> {
  TheacherMeetingListBloc(
      this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(TheacherMeetingListInitial()) {
    on<IsTeacher>(_isTeacher);
    on<DataForTab>(_dataForTab);
    on<ChangeSearch>(_changeSearch);
    on<GetSearchedMeeting>(_getSearchedMeeting);
    on<PressToDelEdit>(_pressToDelEdit);
    on<DeleteMeeting>(_deleteMeeting);
    on<PressFilter>(_pressFilter);
    on<PageIncrement>(_pageIncrement);

    add(IsTeacher());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _isTeacher(
      IsTeacher event, Emitter<TheacherMeetingListState> emit) async {
    final isTeacher =
        await LocalData.isTeacher(localStorageRepo: _localStorageRepo);

    emit(state.copyWith(isTeacher: isTeacher));
  }

  FutureOr<void> _dataForTab(
      DataForTab event, Emitter<TheacherMeetingListState> emit) async {
    emit(state.copyWith(isFirst: false));
    final filterState = event.filterBloc.state;
    emit(state.copyWith(page: 1, loading: true, isEndList: false));

    if (event.tabIndex == '0') {
      emit(state.copyWith(activeTab: '1', loading: true));
    } else if (event.tabIndex == '1') {
      emit(state.copyWith(activeTab: '0', loading: true));
    }

    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "start_date": filterState.startDate,
      "end_date": filterState.endDate,
    };

    final meetingList = await _apiRepo.get<MeetingList>(
        endpoint: buildUrl(
            state.activeTab == '1'
                ? teacherMeetingEndPoint
                : teacherMeetingForTeacherEndPoint,
            queryParams));

    if (meetingList != null) {
      emit(state.copyWith(meetingList: meetingList));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<TheacherMeetingListState> emit) {
    emit(state.copyWith(searchText: event.searchText));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetSearchedMeeting(filterBloc: event.filterBloc));
    });
  }

  FutureOr<void> _getSearchedMeeting(
      GetSearchedMeeting event, Emitter<TheacherMeetingListState> emit) async {
    final filterState = event.filterBloc.state;
    emit(state.copyWith(page: 1, loading: true, isEndList: false));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "start_date": filterState.startDate,
      "end_date": filterState.endDate,
    };

    final meeting = await _apiRepo.get<MeetingList>(
      endpoint: buildUrl(
          state.activeTab == '1'
              ? teacherMeetingEndPoint
              : teacherMeetingForTeacherEndPoint,
          queryParams),
    );

    if (meeting != null) {
      emit(state.copyWith(meetingList: meeting));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pressToDelEdit(
      PressToDelEdit event, Emitter<TheacherMeetingListState> emit) {
    if (event.type == "Delete") {
      showConfirmDeleteDialog(_iFlutterNavigator.context, pressToYes: () {
        add(DeleteMeeting(meetingId: event.id));
      });
    } else if (event.type == "Edit") {
      Navigator.of(_iFlutterNavigator.context, rootNavigator: true)
          .pushNamed(teacherMeetingCreateScreen, arguments: event.id);
    }
  }

  FutureOr<void> _deleteMeeting(
      DeleteMeeting event, Emitter<TheacherMeetingListState> emit) async {
    final delete = await _apiRepo.post<DefaultResponse>(
        endpoint: teacherMeetingDetailsEndPoint(
          meetingId: event.meetingId,
        ),
        body: {"_method": "delete"});

    if (delete != null) {
      _iFlutterNavigator.pop();
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          teacherMeetingListScreen, ModalRoute.withName('/'));
      ShowSnackBar(message: delete.message!, navigator: _iFlutterNavigator);
    }
  }

  FutureOr<void> _pressFilter(
      PressFilter event, Emitter<TheacherMeetingListState> emit) async {
    final filterState = event.filterBloc.state;

    emit(state.copyWith(page: 1, isEndList: false, loading: true));
    final queryParams = {
      "page": state.page,
      "status": state.activeTab,
      "search": state.searchText,
      "start_date": filterState.startDate,
      "end_date": filterState.endDate,
    };

    final meeting = await _apiRepo.get<MeetingList>(
      endpoint: buildUrl(
          state.activeTab == '1'
              ? teacherMeetingEndPoint
              : teacherMeetingForTeacherEndPoint,
          queryParams),
    );
    if (meeting != null) {
      emit(state.copyWith(meetingList: meeting));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<TheacherMeetingListState> emit) async {
    final filterState = event.filterBloc.state;
    int totalPage = state.page + 1;

    if (totalPage <= state.meetingList.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final queryParams = {
          "page": state.page,
          "status": state.activeTab,
          "search": state.searchText,
          "start_date": filterState.startDate,
          "end_date": filterState.endDate,
        };

        final meetingPagi = await _apiRepo.get<MeetingList>(
          endpoint: buildUrl(
              state.activeTab == '1'
                  ? teacherMeetingEndPoint
                  : teacherMeetingForTeacherEndPoint,
              queryParams),
        );

        emit(state.copyWith(page: totalPage, incrementLoader: false));

        if (meetingPagi != null) {
          emit(state.copyWith(
              meetingList: MeetingList(
            data: state.meetingList.data! + meetingPagi.data!,
            lastPage: meetingPagi.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
