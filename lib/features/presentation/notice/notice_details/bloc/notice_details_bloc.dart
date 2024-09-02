import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/notice_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';

part 'notice_details_event.dart';
part 'notice_details_state.dart';

class NoticeDetailsBloc extends Bloc<NoticeDetailsEvent, NoticeDetailsState> {
  NoticeDetailsBloc(
    this._apiRepo,
    this._iFlutterNavigator,
  ) : super(NoticeDetailsInitial()) {
    on<GetNoticeDetails>(_getNoticeDetails);
  }
  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;

  FutureOr<void> _getNoticeDetails(
      GetNoticeDetails event, Emitter<NoticeDetailsState> emit) async {
    final noticeDetails = await _apiRepo.get<NoticeDetailsResponse>(
        endpoint: noticeDetailsEndPoint(id: event.noticeId));

    if (noticeDetails != null) {
      List<String?> fileList = [];

      for (int i = 0; i < noticeDetails.data!.attachments!.length; i++) {
        fileList.add(noticeDetails.data!.attachments![i].file);
      }

      emit(state.copyWith(details: noticeDetails, attachment: fileList));
    }
  }
}
