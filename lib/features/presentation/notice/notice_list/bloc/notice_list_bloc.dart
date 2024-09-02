import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/debounce.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/notice_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';

part 'notice_list_event.dart';
part 'notice_list_state.dart';

class NoticeListBloc extends Bloc<NoticeListEvent, NoticeListState> {
  NoticeListBloc(this._apiRepo, this._iFlutterNavigator, this._localStorageRepo)
      : super(NoticeListInitial()) {
    on<GetNoticeList>(_getNoticeList);
    on<ChangeSearch>(_changeSearch);
    on<PageIncrement>(_pageIncrement);
    on<GetSearchedNotic>(_getSearchedNotic);

    add(GetNoticeList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;

  FutureOr<void> _getNoticeList(
      GetNoticeList event, Emitter<NoticeListState> emit) async {
    final noticeResponse =
        await _apiRepo.get<NoticeResponse>(endpoint: noticeEndPoint);

    if (noticeResponse != null) {
      emit(state.copyWith(notice: noticeResponse));
    }
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<NoticeListState> emit) {
    emit(state.copyWith(searchText: event.searchValue));
    if (state.searchText.isEmpty) {
      emit(state.copyWith(isEndList: false));
    }

    debounce.call(() {
      add(GetSearchedNotic());
    });
  }

  FutureOr<void> _getSearchedNotic(
      GetSearchedNotic event, Emitter<NoticeListState> emit) async {
    emit(state.copyWith(page: 1, loading: true));
    final searchNotice = await _apiRepo.get<NoticeResponse>(
      endpoint: "$noticeEndPoint?search=${state.searchText}",
    );

    if (searchNotice != null) {
      emit(state.copyWith(notice: searchNotice));
    }
    emit(state.copyWith(loading: false));
  }

  FutureOr<void> _pageIncrement(
      PageIncrement event, Emitter<NoticeListState> emit) async {
    int totalPage = state.page + 1;
    if (totalPage <= state.notice.lastPage!) {
      if (!state.incrementLoader) {
        emit(state.copyWith(page: totalPage, incrementLoader: true));

        final noticePagination = await _apiRepo.get<NoticeResponse>(
          endpoint:
              "$noticeEndPoint?search=${state.searchText}&page=${state.page}",
        );
        emit(state.copyWith(page: totalPage, incrementLoader: false));
        if (noticePagination != null) {
          emit(state.copyWith(
              notice: NoticeResponse(
            noticeList: state.notice.noticeList! + noticePagination.noticeList!,
            lastPage: noticePagination.lastPage,
          )));
        }
      }
    } else if (!state.incrementLoader) {
      emit(state.copyWith(isEndList: true));
    }
  }
}
